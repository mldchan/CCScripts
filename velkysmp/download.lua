write("What? ")
local what = read()

if what == "encryption" then
  shell.run("wget https://www.rjek.com/arcfour.lua.txt arcfour.lua")
elseif what == "json" then
	shell.run("wget https://raw.githubusercontent.com/rxi/json.lua/master/json.lua json.lua")
elseif what == "utils" then
  shell.run("wget https://codeberg.org/Akatsuki/ComputerCraftScripts/raw/branch/main/velkysmp/utils.lua utils.lua")
end
