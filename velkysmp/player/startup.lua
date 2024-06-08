
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
con.tell("[Starting] Entity display list")
shell.run(bg .. " /entdisplay.lua")
con.tell("[Started] Entity display list")

-- Spinning fish :3 
con.tell("[Starting] Spinning fish")
shell.run(bg .. " /spinningfish.lua")
con.tell("[Started] Spinning fish")
