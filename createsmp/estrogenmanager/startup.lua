require("utils")
local json = require("json")
local version

if fs.exists("version.json") then
    version = json.decode(readFile("version.json"))
else
    version = { major = 0, minor = 0 }
    writeFile("version.json", json.encode(version))
end
local major = version.major
local minor = version.minor

shell.run("wget https://mldkyt.nekoweb.org/cc/createsmp/estrogenmanager/version.json version_new.json")
local versionNew = json.decode(readFile("version_new.json"))

if major ~= versionNew.major or minor ~= versionNew.minor then
    print("Update available! Downloading...")
    shell.run("downloader")
    print("Update downloaded!")
    writeFile("version.json", json.encode(versionNew))
    fs.delete("version_new.json")
    print("Restarting...")
    os.reboot()
end

if fs.exists("version_new.json") then
    fs.delete("version_new.json")
end

print("Running latest version (" .. major .. "." .. minor .. ")")

shell.run("main")
