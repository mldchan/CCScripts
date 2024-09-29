fs.delete("downloader.lua")
fs.delete("main.lua")
fs.delete("setup.lua")
fs.delete("startup.lua")

shell.run("wget https://mldkyt.nekoweb.org/cc/createsmp/farmerbot/downloader.lua downloader.lua")
shell.run("wget https://mldkyt.nekoweb.org/cc/createsmp/farmerbot/main.lua main.lua")
shell.run("wget https://mldkyt.nekoweb.org/cc/createsmp/farmerbot/startup.lua startup.lua")
if not fs.exists("utils.lua") then
    shell.run("wget https://mldkyt.nekoweb.org/cc/velkysmp/utils.lua utils.lua")
end
if not fs.exists("json.lua") then
    shell.run("wget https://raw.githubusercontent.com/rxi/json.lua/master/json.lua json.lua")
end
if not fs.exists("aeslua.lua") then
    shell.run(
        "wget https://gist.githubusercontent.com/perara/77b82012bdd2a702c98a714b57e1fb85/raw/ccea5f652cc33a979de02d6e0fe193db0c5bdfb1/aeslua.lua")
end
