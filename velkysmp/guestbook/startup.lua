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

function downloadFile(f, url)
    print(f.. ": downloading update..")
    -- Append a bit of randomness to URL, after a ?
    l = l .. "?" .. math.random(1, 1000000)
    -- Get string
    local startupUpdate = http.get(url)
    local startusCode, statusMessage = startupUpdate.getResponseCode()
    if startusCode ~= 200 then
        printError("Server responded with message " .. statusMessage)
        return
    end

    local fileC = startupUpdate.readAll()

    print(f..": deleting...")
    -- Delete the startup file
    fs.delete(f..".lua")

    print(f..": replacing..")
    -- Recreate the startup file
    local file = fs.open(f..".lua", "w")
    file.write(fileC)
    file.close()
    print(f..": done updating.")
end

downloadFile("startup", "https://akatsuki.nekoweb.org/cc/velkysmp/guestbook/startup.lua")
downloadFile("json", "https://raw.githubusercontent.com/rxi/json.lua/master/json.lua")
downloadFile("main", "https://akatsuki.nekoweb.org/cc/velkysmp/guestbook/main.lua")
downloadFile("utils", "https://akatsuki.nekoweb.org/cc/velkysmp/utils.lua")
downloadFile("keyboard", "https://akatsuki.nekoweb.org/cc/velkysmp/guestbook/keyboard.lua")

-- startup alret

require("utils")
local json = require("json")
local config = json.decode(readFile("config.json"))

http.post(config.webhook, json.encode({
    content = "Computer " .. os.getComputerID() .. " has been started!"
}), {
    ["Content-Type"] = "application/json"
})


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