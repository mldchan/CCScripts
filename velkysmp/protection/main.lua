
require("utils")
local json = require("json")

local config = json.decode(readFile("config.json"))

while true do
    event, p1, p2, p3, p4, p5 = os.pullEvent("peripheral_detach")
    
    http.post(config.webhook, json.encode({
        content = "Peripheral " .. p1 .. " was detached! <@" .. config.userId .. ">"
    }), {
        ["Content-Type"] = "application/json"
    })

end
