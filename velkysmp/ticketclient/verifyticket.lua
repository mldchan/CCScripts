-- ComputerCraftScripts
-- Copyright (C) 2024  Akatsuki

-- This program is free software: you can redistribute it and/or modify it under the terms of the 
-- GNU General Public License as published by the Free Software Foundation, either version 3 of 
-- the License, or (at your option) any later version.

-- This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without 
-- even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License along with this program. 
-- If not, see <https://www.gnu.org/licenses/>.


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
