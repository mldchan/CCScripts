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

-- wget run https://raw.githubusercontent.com/Akatsuki2555/CCScripts/main/velkysmp/starter/startup.lua

function downloadFile(f, l)
    print(f .. ": downloading update..")
    -- Get string
    local startupUpdate, errorMessage = http.get(l)
    if startupUpdate == nil then
        printError("Error while trying to download file " .. errorMessage)
    end
    local status, message = startupUpdate.getResponseCode()
    if status ~= 200 then
        printError("Server responded with message " .. message)
        return
    end

    local fileC = startupUpdate.readAll()

    print(f .. ": deleting...")
    -- Delete the startup file
    fs.delete(f .. ".lua")

    print(f .. ": replacing..")
    -- Recreate the startup file
    local file = fs.open(f .. ".lua", "w")
    file.write(fileC)
    file.close()
    print(f .. ": done updating.")
end

downloadFile("startup", "https://raw.githubusercontent.com/Akatsuki2555/CCScripts/main/velkysmp/starter/startup.lua")
downloadFile("json", "https://raw.githubusercontent.com/rxi/json.lua/master/json.lua")
downloadFile("utils", "https://raw.githubusercontent.com/Akatsuki2555/CCScripts/main/velkysmp/utils.lua")

local function scanNetwork()
    print("Scanning network for offline computers...")
    
    local computers = {}
    
    -- Get a list of all connected peripherals
    local peripherals = peripheral.getNames()
    
    -- Filter out the computers
    for _, peripheralName in ipairs(peripherals) do
        if peripheral.getType(peripheralName) == "computer" then
            table.insert(computers, peripheral.wrap(peripheralName))
        end
    end
    
    -- Check the status of each computer
    for _, computer in ipairs(computers) do
        if not computer.isOn() then
            print("Computer offline: " .. computer.getID())
        end
    end
    
    print("Network scan complete.")
end

scanNetwork()

local function turnOnAllComputers()
    print("Turning on all computers...")
    
    local computers = {}
    
    -- Get a list of all connected peripherals
    local peripherals = peripheral.getNames()
    
    -- Filter out the computers
    for _, peripheralName in ipairs(peripherals) do
        if peripheral.getType(peripheralName) == "computer" then
            table.insert(computers, peripheral.wrap(peripheralName))
        end
    end
    
    -- Check the status of each computer and turn it on if it's offline
    for _, computer in ipairs(computers) do
        if not computer.isOn() then
            computer.turnOn()
            print("Computer turned on: " .. computer.getID())
        else
            print("Computer already online: " .. computer.getID())
        end
    end
    
    print("All computers turned on.")
end

turnOnAllComputers()
