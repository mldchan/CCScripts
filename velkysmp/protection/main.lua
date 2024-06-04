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
        local computers = { rednet.lookup("Akatsuki") }

        for index, value in ipairs(computers) do
            print("Checking " .. tostring(value))

            if value == os.getComputerID() then
                goto continue
            end

            rednet.send(value, "ping", "Akatsuki")
            local id, msg = rednet.receive("Akatsuki", 1)
            if id ~= nil then
                -- Computer responded, add to knownComputers if not already there
                if not knownComputers[value] then
                    print("Registering new known computer " .. tostring(value))
                    knownComputers[value] = true
                    http.post(config.webhook, json.encode({
                        content = "Computer " .. value .. " has connected!"
                    }), {
                        ["Content-Type"] = "application/json"
                    })
                end
            else
                -- Computer did not respond, send notification
                if knownComputers[value] then
                    print("Computer " .. value .. " did not respond!")
                    http.post(config.webhook, json.encode({
                        content = "Computer " .. value .. " did not respond! <@" .. config.userId .. ">"
                    }), {
                        ["Content-Type"] = "application/json"
                    })

                    knownComputers[value] = nil -- disable repeated pings for PC
                end
            end
            ::continue::
        end

        -- ping all known computers
        for index, value in pairs(knownComputers) do
            rednet.send(index, "ping", "Akatsuki")
            local id, msg = rednet.receive("Akatsuki", 1)
            if id == nil then
                http.post(config.webhook, json.encode({
                    content = "Computer " .. index .. " did not respond! <@" .. config.userId .. ">"
                }), {
                    ["Content-Type"] = "application/json"
                })
            end
        end
    end

    if event == "rednet_message" then
        -- p1 - sender id, p2 - message, p3 - protocol
        if p2 == "ping" and p3 == "Akatsuki" then
            rednet.send(p1, "pong", "Akatsuki")
        end
    end

    writeToLog("log " ..
    tostring(event) ..
    " " .. tostring(p1) .. " " .. tostring(p2) .. " " .. tostring(p3) .. " " .. tostring(p4) .. " " .. tostring(p5))
end
