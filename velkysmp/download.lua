write("What? ")
local what = read()

if what == "encryption" then
  shell.run("wget https://gist.githubusercontent.com/perara/77b82012bdd2a702c98a714b57e1fb85/raw/ccea5f652cc33a979de02d6e0fe193db0c5bdfb1/aeslua.lua")
elseif what == "json" then
	shell.run("wget https://raw.githubusercontent.com/rxi/json.lua/master/json.lua json.lua")
elseif what == "utils" then
  shell.run("wget https://codeberg.org/Akatsuki/ComputerCraftScripts/raw/branch/main/velkysmp/utils.lua utils.lua")
end
