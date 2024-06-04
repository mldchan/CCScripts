require("utils")
local json = require("json")

function writeToLog(msg)
    local log = readFile("log.txt")
    log = log .. "\n" .. msg
    writeFile("log.txt", log)
end

local config = json.decode(readFile("config.json"))

rednet.open(config.modemSide)
rednet.host("Akatsuki", config.hostname)

local knownComputers = {}
local computerMsgsStatus = {}
-- there are 3 states in computerMsgsStatus: nil, "sent", "received"

while true do
    os.startTimer(5)
    event, p1, p2, p3, p4, p5 = os.pullEvent()

    if event == "peripheral_detach" then
        -- p1 - side, p2 - type
        http.post(config.webhook, json.encode({
            content = "Peripheral " .. p1 .. " was detached! <@" .. config.userId .. ">"
        }), {
            ["Content-Type"] = "application/json"
        })
    end

    if event == "timer" then
        -- p1 - timer id
        for index, value in pairs(computerMsgsStatus) do
            print("Computer " .. index .. " status: " .. value)
            if value == "sent" then
                http.post(config.webhook, json.encode({
                    content = "Computer " .. index .. " did not respond! <@" .. config.userId .. ">"
                }), {
                    ["Content-Type"] = "application/json"
                })
            end
        end

        local computers = { rednet.lookup("Akatsuki") }

        -- remove self from table if inside
        for index, value in ipairs(computers) do
            if value == os.getComputerID() then
                table.remove(computers, index)
            end
        end

        -- add missing computers to knownComputers
        for index, value in ipairs(computers) do
            if not knownComputers[value] then
                print("Registering new known computer " .. tostring(value))
                knownComputers[value] = true
                http.post(config.webhook, json.encode({
                    content = "Computer " .. value .. " has connected! <@" .. config.userId .. ">"
                }), {
                    ["Content-Type"] = "application/json"
                })
            end
        end

        -- check computers for any PC's that dissapeared
        -- send message on Discord
        for index, _ in ipairs(computers) do
            if not knownComputers[index] then
                print("Computer " .. index .. " has disconnected!")
                http.post(config.webhook, json.encode({
                    content = "Computer " .. index .. " has disconnected! <@" .. config.userId .. ">"
                }), {
                    ["Content-Type"] = "application/json"
                })

                knownComputers[index] = nil
            end
        end

        for index, value in ipairs(computers) do
            print("Checking " .. tostring(value))

            rednet.send(value, "ping", "Akatsuki")
            print("Sent ping to " .. tostring(value))
            computerMsgsStatus[value] = "sent"
        end
    end

    if event == "rednet_message" then
        -- p1 - sender id, p2 - message, p3 - protocol
        if p2 == "ping" and p3 == "Akatsuki" then
            rednet.send(p1, "pong", "Akatsuki")
            print("Ping response sent to " .. tostring(p1))
        end

        if p2 == "pong" and p3 == "Akatsuki" then
            print("Received pong from " .. tostring(p1))
            computerMsgsStatus[p1] = "received"
        end
    end

    writeToLog("log " ..
    tostring(event) ..
    " " .. tostring(p1) .. " " .. tostring(p2) .. " " .. tostring(p3) .. " " .. tostring(p4) .. " " .. tostring(p5))
end
