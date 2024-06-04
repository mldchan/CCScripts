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

        for index, value in ipairs(computers) do
            print("Checking " .. tostring(value))

            rednet.send(value, "ping", "Akatsuki")
            print("Sent ping to " .. tostring(value))
            computerMsgsStatus[value] = "sent"
            -- local id, msg = rednet.receive("Akatsuki", 1)
            -- if id ~= nil then
            --     -- Computer responded, add to knownComputers if not already there
            --     if not knownComputers[value] then
            --         print("Registering new known computer " .. tostring(value))
            --         knownComputers[value] = true
            --         http.post(config.webhook, json.encode({
            --             content = "Computer " .. value .. " has connected!"
            --         }), {
            --             ["Content-Type"] = "application/json"
            --         })
            --     end
            -- else
            --     -- Computer did not respond, send notification
            --     if knownComputers[value] then
            --         print("Computer " .. value .. " did not respond!")
            --         http.post(config.webhook, json.encode({
            --             content = "Computer " .. value .. " did not respond! <@" .. config.userId .. ">"
            --         }), {
            --             ["Content-Type"] = "application/json"
            --         })

            --         knownComputers[value] = nil -- disable repeated pings for PC
            --     end
            -- end
        end

        -- ping all known computers
        for index, value in pairs(knownComputers) do
            rednet.send(index, "ping", "Akatsuki")
            computerMsgsStatus[index] = "sent"
            -- local id, msg = rednet.receive("Akatsuki", 1)
            -- if id == nil then
            --     http.post(config.webhook, json.encode({
            --         content = "Computer " .. index .. " did not respond! <@" .. config.userId .. ">"
            --     }), {
            --         ["Content-Type"] = "application/json"
            --     })
            -- end
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
            -- for index, value in pairs(computerMsgsStatus) do
            --     if value == p1 then
            --         print("Found computer " .. tostring(index) .. " in computerMsgsStatus")
            --         computerMsgsStatus[index] = "received"
            --         if not knownComputers[index] then
            --             print("Registering new known computer " .. tostring(index))
            --             knownComputers[index] = true
            --             http.post(config.webhook, json.encode({
            --                 content = "Computer " .. index .. " has connected!"
            --             }), {
            --                 ["Content-Type"] = "application/json"
            --             })
            --         end
            --     end
            -- end
            computerMsgsStatus[p1] = "received"
            knownComputers[p1] = true
        end
    end

    writeToLog("log " ..
    tostring(event) ..
    " " .. tostring(p1) .. " " .. tostring(p2) .. " " .. tostring(p3) .. " " .. tostring(p4) .. " " .. tostring(p5))
end
