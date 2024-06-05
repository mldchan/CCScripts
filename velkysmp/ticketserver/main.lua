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


MODEM_SIDE = "right"

local json = require("json")

function readData()
    local file = fs.open("data.json", "r")
    local data = file.readAll()
    file.close()
    return data
end

function writeData(data)
    local file = fs.open("data.json", "w")
    file.write(data)
    file.close()
end

if not fs.exists("data.json") then
    print("Creating data.json")
    writeData("[]")
end

rednet.open(MODEM_SIDE)
rednet.host("Akatsuki", "ticketserver")

while true do
    computer, message = rednet.receive("Akatsuki", 1)
    if computer ~= nil then
        message = json.decode(message)
        if message.type == "generateticket" then
            local data = readData()
            data = json.decode(data)
            local ticket = {
                name = message.name,
                ticket = math.random(100000, 999999)
            }
            table.insert(data, ticket)
            writeData(json.encode(data))
            rednet.send(computer, json.encode({type = "ticketgenerated", ticket = ticket.ticket}), "Akatsuki")
        elseif message.type == "verifyticket" then
            local data = readData()
            data = json.decode(data)
            for k, v in ipairs(data) do
                if v.ticket == message.ticket then
                    rednet.send(computer, json.encode({type = "ticketverified", name = v.name}), "Akatsuki")
                    break
                end
            end
        end
    end

    os.sleep(0)
end
