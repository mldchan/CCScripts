MODEM_SIDE = "left"

require("input")
local json = require("json")

local ticket = prompt("Ticket number: ")

local message = json.encode({type = "verifyticket", ticket = tonumber(ticket)})

rednet.open(MODEM_SIDE)

local host = rednet.lookup("Akatsuki", "ticketserver")

if host == nil then
    print("Ticket server not found!")
    return
end

rednet.send(host, message, "Akatsuki")

local computer, message = rednet.receive("Akatsuki", 1)

if computer == nil then
    print("Ticket is not valid!")
    return
end

message = json.decode(message)

print("The ticket is valid and belongs to " .. tostring(message.name))
