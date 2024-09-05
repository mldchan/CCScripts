--- GNU General Public License v3.0 ---

--- ComputerCraftScripts ---
--- Copyright (C) 2024  mldkyt ---

--- This program is free software: you can redistribute it and/or modify it under the terms of the 
--- GNU General Public License as published by the Free Software Foundation, either version 3 of 
--- the License, or (at your option) any later version.

--- This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without 
--- even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--- GNU General Public License for more details.

--- You should have received a copy of the GNU General Public License along with this program. 
--- If not, see <https://www.gnu.org/licenses/>.

require("utils")
local json = require("json")

if not fs.exists("version.json") then
    print("version.json not found. Setting default version.")
    local default_version = { version = 1 }
    writeFile("version.json", json.encode(default_version))
end

local version = json.decode(readFile("version.json"))

print("Ad program version "..version.version.." started")

function downloadFile(f, url)
    print(f.. ": downloading update..")
    -- Get string
    local startupUpdate = http.get(url)
    local startusCode, statusMessage = startupUpdate.getResponseCode()
    if startusCode ~= 200 then
        printError("Server responded with message " .. statusMessage)
        return
    else
        file = fs.open(f..".lua", "w")
        file.write(startupUpdate.readAll())
        file.close()
        print(f..": done updating.")
    end
end

local function checkForUpdates()
    local version_info = json.decode(http.get("https://mldkyt.nekoweb.org/cc/createsmp/ad.json").readAll())
    if version_info.version > version.version then
        term.setTextColor(colors.green)
        print("New version v"..version_info.version.." was found, downloading...")
        term.setTextColor(colors.white)
        downloadFile("ad", "https://mldkyt.nekoweb.org/cc/createsmp/main.lua")
        -- write version.json
        local file = fs.open("version.json", "w")
        file.write(json.encode(version_info))
        file.close()
        term.setTextColor(colors.green)
        print("Update downloaded, restarting...")
        term.setTextColor(colors.white)
        os.reboot()
    else
        term.setTextColor(colors.green)
        print("No updates found! Latest version is v"..version_info.version)
        term.setTextColor(colors.white)
    end
end

local function main()
    print("Running Ad program...")
    local monitor = peripheral.wrap("monitor_0")
    local message = "femboy.bio/mldkyt"
    local width, height = monitor.getSize()
    monitor.clear()
    monitor.setTextColor(colors.white)
    monitor.setCursorPos(width / 2 - #message / 2, height / 2)
    monitor.write(message)
    monitor.setCursorPos(1, height)
end

checkForUpdates()
main()
