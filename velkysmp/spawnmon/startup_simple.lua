
peripheral.call("right", "clear")

print("Checking updates...")
fs.delete("startup.lua")
shell.run("wget https://akatsuki.nekoweb.org/cc/spawnmon/startup_simple.lua startup.lua")
fs.delete("json.lua")
shell.run("wget https://raw.githubusercontent.com/rxi/json.lua/master/json.lua json.lua")
fs.delete("main.lua")
shell.run("wget https://akatsuki.nekoweb.org/cc/spawnmon/main_simple.lua main.lua")

term.clear()

print("Running main.lua...")
shell.run("main.lua")
