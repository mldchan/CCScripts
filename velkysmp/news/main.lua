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
local mon = peripheral.wrap("monitor_1")

local news = http.get("https://akatsuki.nekoweb.org/news.json")
local newsJson = json.decode(news.readAll())

for i, v in ipairs(newsJson) do
	if i == 3 then
        return
    end

    mon.setCursorPos(1, i)
    mon.write(v.date .. " -- " .. v.content)
end

while true do
    evt, p1, p2, p3, p4, p5 = os.pullEventRaw()
end
