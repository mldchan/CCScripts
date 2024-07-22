-- ComputerCraft

per = peripheral.wrap("back")

rednet.open("left")

while true do
    evt, p1, p2, p3, p4, p5 = os.pullEvent()
    p1 = p1 or "[n]"
    p2 = p2 or "[n]"
    p3 = p3 or "[n]"
    p4 = p4 or "[n]"
    p5 = p5 or "[n]"
    per.tell(evt .. ": " .. tostring(p1) .. " " .. tostring(p2) .. " " .. tostring(p3) .. " " .. tostring(p4) .. " " .. tostring(p5))
end
