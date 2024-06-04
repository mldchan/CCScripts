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
        -- http.post(config.webhook, json.encode({
        --     content = "Peripheral " .. p1 .. " was detached! <@" .. config.userId .. ">"
        -- }), {
        --     ["Content-Type"] = "application/json"
        -- })
    end

    if event == "timer" then
        -- p1 - timer id
        for index, value in pairs(computerMsgsStatus) do
            print("Computer " .. index .. " status: " .. value)
            if value == "sent" then
                -- http.post(config.webhook, json.encode({
                --     content = "Computer " .. index .. " did not respond! <@" .. config.userId .. ">"
                -- }), {
                --     ["Content-Type"] = "application/json"
                -- })
            end
        end
        
        rednet.broadcast("ping", "Akatsuki")
        -- set all known computers to "Sent"
        for index, value in pairs(knownComputers) do
            computerMsgsStatus[index] = "sent"
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
            -- add to list of known computers if not already there
            if not knownComputers[p1] then
                print("Registering new known computer " .. tostring(p1))
                knownComputers[p1] = true
                -- http.post(config.webhook, json.encode({
                --     content = "Computer " .. p1 .. " has connected!"
                -- }), {
                --     ["Content-Type"] = "application/json"
                -- })
            end
        end
    end

    writeToLog("log " ..
    tostring(event) ..
    " " .. tostring(p1) .. " " .. tostring(p2) .. " " .. tostring(p3) .. " " .. tostring(p4) .. " " .. tostring(p5))
end
