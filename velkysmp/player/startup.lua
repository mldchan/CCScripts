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

con = peripheral.wrap("back")

function updateLib()
  fs.delete("akatsuki.lua")
  shell.run("wget https://codeberg.org/Akatsuki/ComputerCraftScripts/raw/branch/main/velkysmp/player/akatsuki.lua")
  fs.delete("startup.lua")
  shell.run("wget https://codeberg.org/Akatsuki/ComputerCraftScripts/raw/branch/main/velkysmp/player/startup.lua")
end

con.tell("Starting AkatsukiOS...")
updateLib()

require("akatsuki")

con.tell("Checking for updates and downloading them...")
checkForUpdates()
con.tell("Checking for updates was finished.")

local bg = shell.resolveProgram("bg")
print("bg is", bg)

-- Meowing
con.tell("[Starting] Automatic meowing")
shell.run(bg .. " /meow.lua")
con.tell("[Started] Automatic meowing")

-- Entity display
-- con.tell("[Starting] Entity display list")
-- shell.run(bg .. " /entdisplay.lua")
-- con.tell("[Started] Entity display list")

-- Spinning fish :3 
-- con.tell("[Starting] Spinning fish")
-- shell.run(bg .. " /spinningfish.lua")
-- con.tell("[Started] Spinning fish")

-- Net logger
con.tell("[Starting] Net logger")
shell.run(bg .. " /netlogger.lua")
con.tell("[Started] Net logger")

-- UI
con.tell("[Starting] User interface")
shell.run(bg .. " /ui.lua")
con.tell("[Started] User interface")
