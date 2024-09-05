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

downloadFile("json", "https://raw.githubusercontent.com/rxi/json.lua/master/json.lua")
downloadFile("utils", "https://mldkyt.nekoweb.org/cc/createsmp/utils.lua")
downloadFile("ad", "https://mldkyt.nekoweb.org/cc/createsmp/main.lua")

shell.run("ad")