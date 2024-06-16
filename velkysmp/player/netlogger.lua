-- ComputerCraft

per = peripheral.wrap("back")

function appendToFile(log)
    local logFile = fs.open("log.txt", "a")
    logFile.writeLine(log)
    logFile.close()
end

while true do
    evt, p1, p2, p3, p4, p5 = os.pullEvent()

    if evt == "rednet_message" then
        -- print("Received message from " .. p1 .. ": " .. p3)
        -- appendToFile("Received message from " .. p1 .. ": " .. p3)
        per.tell("Received message from " .. p1 .. ": " .. p3)
    end
end
