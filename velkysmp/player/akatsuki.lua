

function checkForUpdates()
  fs.delete("entdisplay.lua")
  shell.run("wget https://codeberg.org/Akatsuki/ComputerCraftScripts/raw/commit/main/velkysmp/player/entdisplay.lua")

  fs.delete("entsense.lua")
  shell.run("wget https://codeberg.org/Akatsuki/ComputerCraftScripts/raw/commit/main/velkysmp/player/entsense.lua")

  fs.delete("meow.lua")
  shell.run("wget https://codeberg.org/Akatsuki/ComputerCraftScripts/raw/commit/main/velkysmp/player/meow.lua")

  fs.delete("spinningfish.lua")
  shell.run("wget https://codeberg.org/Akatsuki/ComputerCraftScripts/raw/commit/main/velkysmp/player/spinningfish.lua")

end
