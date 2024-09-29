
function selectWheat()
    for i = 1, 16 do
        turtle.select(i)
        if turtle.getItemCount(i) > 0 then
            if turtle.getItemDetail(i).name == "minecraft:wheat" then
                return true
            end
        end
    end
    return false
end

while true do
    if not turtle.forward() then
        turtle.turnRight()
        turtle.forward()
        turtle.turnRight()
    end
    selectWheat()
    turtle.placeDown()
    os.sleep(0.05)
end
