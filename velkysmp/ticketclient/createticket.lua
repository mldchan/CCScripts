MODEM_SIDE = "left"

require("input")
local json = require("json")

rednet.open(MODEM_SIDE)
local ticketServer = rednet.lookup("Akatsuki", "ticketserver")

if ticketServer == nil then
    print("Ticket server not found!")
    return
end

local name = prompt("Enter your name: ")

rednet.send(ticketServer, json.encode({type = "generateticket", name = name}), "Akatsuki")
local computer, message = rednet.receive("Akatsuki", 1)
if computer == nil then
    print("Ticket server did not respond!")
    return
end

message = json.decode(message)
if message.type ~= "ticketgenerated" then
    print("Ticket server did not respond with a ticket!")
    return
end

print("Your ticket is: " .. tostring(message.ticket))

