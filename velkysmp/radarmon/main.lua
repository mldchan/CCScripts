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
local json = require("json")
local config = json.decode(readFile("config.json"))

radar = peripheral.wrap("back") -- Radar peripheral

local playersKnown = {} -- Names of players currently known

while true do
    os.queueEvent("tesuto")
    event, p1, p2, p3, p4, p5 = os.pullEventRaw()

    local playersScanned = radar.getPlayers()

    -- Add players not known to playersKnown, the format is [{distance, name}]

    for _, player in ipairs(playersScanned) do
        local playerKnown = false
        for _, known in ipairs(playersKnown) do
            if known == player.name then
                playerKnown = true
                break
            end
        end

        if not playerKnown then
            table.insert(playersKnown, player.name)
            http.post(config.webhook, json.encode({
                content = "Player " .. player.name .. " was detected at base!",
                username = "Radar"
            }), {
                ["Content-Type"] = "application/json"
            })
        end
    end

    -- Remove players not scanned from playersKnown

    for i = #playersKnown, 1, -1 do
        local playerKnown = false
        for _, player in ipairs(playersScanned) do
            if playersKnown[i] == player.name then
                playerKnown = true
                break
            end
        end

        if not playerKnown then
            table.remove(playersKnown, i)
            http.post(config.webhook, json.encode({
                content = "Player " .. playersKnown[i] .. " was no longer detected at base!",
                username = "Radar"
            }), {
                ["Content-Type"] = "application/json"
            })
        end
    end
end
