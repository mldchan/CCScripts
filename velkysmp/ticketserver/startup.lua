
fs.delete("startup.lua")
shell.run("wget https://akatsuki.nekoweb.org/cc/ticketserver/startup.lua startup.lua")
fs.delete("json.lua")
shell.run("wget https://raw.githubusercontent.com/rxi/json.lua/master/json.lua json.lua")
fs.delete("main.lua")
shell.run("wget https://akatsuki.nekoweb.org/cc/ticketserver/main.lua main.lua")

shell.run("main.lua")
