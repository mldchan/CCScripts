-- ComputerCraft

per = peripheral.wrap("back")

while true do
    evt, p1, p2, p3, p4, p5 = os.pullEvent()
    p1 = p1 or "[1]"
    p2 = p2 or "[2]"
    p3 = p3 or "[3]"
    p4 = p4 or "[4]"
    p5 = p5 or "[5]"
    per.tell(evt .. ": " .. p1 .. " " .. p2 .. " " .. p3 .. " " .. p4 .. " " .. p5)
end
