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

require("utils")
require("aeslua")
local json = require("json")
local config = json.decode(readFile("config.json"))

if not fs.exists("data.json") then
	print("Creating data.json")
	writeData("[]")
end

rednet.open(config.modemSide)
rednet.host("Akatsuki", "ticketserver")

while true do
	computer, message = rednet.receive("Akatsuki", 1)
	if computer ~= nil then
		message = decrypt(config.aesPassword, message)
		if message ~= nil then
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
				message = json.encode({ type = "ticketgenerated", ticket = ticket.ticket })
				message = encrypt(config.aesPassword, message)
				rednet.send(computer, message, "Akatsuki")
			elseif message.type == "verifyticket" then
				local data = readData()
				data = decrypt(config.aesPassword, data)
				if data ~= nil then
					data = json.decode(data)
					for k, v in ipairs(data) do
						if v.ticket == message.ticket then
							rednet.send(computer, json.encode({ type = "ticketverified", name = v.name }), "Akatsuki")
							break
						end
					end
				end
			end
		end
	end

	os.sleep(0)
end
