MODEM_SIDE = "right"

local json = require("json")

function readData()
    local file = fs.open("data.json", "r")
    local data = file.readAll()
    file.close()
    return data
end

function writeData(data)
    local file = fs.open("data.json", "w")
    file.write(data)
    file.close()
end

if not fs.exists("data.json") then
    print("Creating data.json")
    writeData("[]")
end

rednet.open(MODEM_SIDE)
rednet.host("Akatsuki", "ticketserver")

while true do
    computer, message = rednet.receive("Akatsuki", 1)
    if computer ~= nil then
        message = json.decode(message)
        if message.type == "generateticket" then
            local data = readData()
            data = json.decode(data)
            local ticket = {
                name = message.name,
                ticket = math.random(100000, 999999)
            }
            table.insert(data, ticket)
            writeData(json.encode(data))
            rednet.send(computer, json.encode({type = "ticketgenerated", ticket = ticket.ticket}), "Akatsuki")
        elseif message.type == "verifyticket" then
            local data = readData()
            data = json.decode(data)
            for k, v in ipairs(data) do
                if v.ticket == message.ticket then
                    rednet.send(computer, json.encode({type = "ticketverified", name = v.name}), "Akatsuki")
                    break
                end
            end
        end
    end

    os.sleep(0)
end
