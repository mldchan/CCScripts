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

settings.set("shell.allow_disk_startup", false)

require("utils")
local json = require("json")
local config = json.decode(readFile("config.json"))

-- startup alret

http.post(config.webhook, json.encode({
    content = "Computer " .. os.getComputerID() .. " has been started!"
}), {
    ["Content-Type"] = "application/json"
})

fs.delete("startup.lua")
shell.run("wget https://codeberg.org/Akatsuki/ComputerCraftScripts/raw/branch/main/velkysmp/guestbook/startup.lua startup.lua")
fs.delete("json.lua")
shell.run("wget https://raw.githubusercontent.com/rxi/json.lua/master/json.lua json.lua")
fs.delete("main.lua")
shell.run("wget https://codeberg.org/Akatsuki/ComputerCraftScripts/raw/branch/main/velkysmp/guestbook/main.lua main.lua")
fs.delete("utils.lua")
shell.run("wget https://codeberg.org/Akatsuki/ComputerCraftScripts/raw/branch/main/velkysmp/utils.lua utils.lua")

peripheral.call("back", "setTextScale", 1)
shell.run("main.lua")



prettyWrite(term, "Nice try. I see you.")


http.post(config.webhook, json.encode({
    content = "Computer " .. os.getComputerID() .. " had it's program terminated! <@" .. config.userId .. ">"
}), {
    ["Content-Type"] = "application/json"
})

prettyWrite(term, "Akatsuki was alerted. Please don't try this again.")
print()
prettyWrite(term, "Unless you just wanted to update the program. In that case, please wait a moment.")
print()

os.sleep(1)

os.reboot()