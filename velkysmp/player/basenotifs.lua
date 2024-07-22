require("aeslua")
require("utils")
local json = require("json")
local player = peripheral.wrap("back") -- The neural thingy module from Plethora

-- Assuming the config and utility functions are similar to the sender's
local config = json.decode(readFile("config.json"))

-- Open the modem on the correct side. Adjust "right" to match your setup.
rednet.open("top")

while true do
    local senderId, message, protocol = rednet.receive()
    local decryptedMessage = decrypt(config.password, message)
    if decryptedMessage ~= nil then
        local messageTable = json.decode(decryptedMessage)
        if messageTable.action == "enter" then
            player.tell("[Base] Player " .. messageTable.player .. " has entered the base!")
        elseif messageTable.action == "leave" then
            player.tell("[Base] Player " .. messageTable.player .. " has left the base!")
        end
    end
end