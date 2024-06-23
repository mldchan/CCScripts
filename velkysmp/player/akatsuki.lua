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

function checkForUpdates()
  fs.delete("entdisplay.lua")
  shell.run("wget https://raw.githubusercontent.com/Akatsuki2555/CCScripts/main/velkysmp/player/entdisplay.lua")

  fs.delete("entsense.lua")
  shell.run("wget https://raw.githubusercontent.com/Akatsuki2555/CCScripts/main/velkysmp/player/entsense.lua")

  fs.delete("meow.lua")
  shell.run("wget https://raw.githubusercontent.com/Akatsuki2555/CCScripts/main/velkysmp/player/meow.lua")

  fs.delete("spinningfish.lua")
  shell.run("wget https://raw.githubusercontent.com/Akatsuki2555/CCScripts/main/velkysmp/player/spinningfish.lua")

  fs.delete("netlogger.lua")
  shell.run("wget https://raw.githubusercontent.com/Akatsuki2555/CCScripts/main/velkysmp/player/netlogger.lua")

  fs.delete("ui.lua")
  shell.run("wget https://raw.githubusercontent.com/Akatsuki2555/CCScripts/main/velkysmp/player/ui.lua")

end
