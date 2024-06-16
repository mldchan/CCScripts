-- ComputerCraft

per = peripheral.wrap("back")

while true do
    evt, p1, p2, p3, p4, p5 = os.pullEvent()
    per.tell(evt .. ": " .. p1 .. " " .. p2 .. " " .. p3 .. " " .. p4 .. " " .. p5)
end
