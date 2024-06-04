-- wget run https://codeberg.org/Akatsuki/ComputerCraftScripts/raw/branch/main/velkysmp/spawnmon/startup.lua
peripheral.call("right", "clear")

print("Checking updates...")
fs.delete("startup.lua")
shell.run("wget https://codeberg.org/Akatsuki/ComputerCraftScripts/raw/branch/main/velkysmp/spawnmon/startup.lua startup.lua")
fs.delete("json.lua")
shell.run("wget https://raw.githubusercontent.com/rxi/json.lua/master/json.lua json.lua")
fs.delete("main.lua")
shell.run("wget https://codeberg.org/Akatsuki/ComputerCraftScripts/raw/branch/main/velkysmp/spawnmon/main.lua main.lua")
fs.delete("utils.lua")
shell.run("wget https://codeberg.org/Akatsuki/ComputerCraftScripts/raw/branch/main/velkysmp/utils.lua utils.lua")

term.clear()

print("Running main.lua...")
shell.run("main.lua")

prettyWrite(term, "Nice try. I see you.")

http.post(config.webhook, json.encode({
    content = "Computer " .. os.getComputerID() .. " had it's program terminated! <@" .. config.userId .. ">"
}), {
    ["Content-Type"] = "application/json"
})

prettyWrite(term, "Akatsuki was alerted. Please don't try this again.")
prettyWrite(term, "Unless you just wanted to update the program. In that case, please wait a moment.")

os.sleep(1)

os.reboot()
