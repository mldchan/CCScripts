
con = peripheral.wrap("back")

function updateLib()
  fs.delete("akatsuki.lua")
  shell.run("wget https://codeberg.org/Akatsuki/ComputerCraftScripts/raw/branch/main/velkysmp/player/akatsuki.lua")
end

con.tell("Starting AkatsukiOS...")
updateLib()

local akatsuki = require("akatsuki")

con.tell("Checking for updates and downloading them...")
akatsuki.checkForUpdates()
con.tell("Checking for updates was finished.")

-- Meowing
con.tell("[Starting] Automatic meowing")
shell.run("bg meow")
con.tell("[Started] Automatic meowing")

-- Entity display
con.tell("[Starting] Entity display list")
shell.run("bg entdisplay")
con.tell("[Started] Entity display list")

-- Spinning fish :3 
con.tell("[Starting] Spinning fish")
shell.run("bg spinningfish")
con.tell("[Started] Spinning fish")
