
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

local function flip()
    turtle.turnRight()
    turtle.turnRight()
end

while true do
    if not turtle.forward() then
        turtle.turnRight()
        if not turtle.forward() then
            flip()
            if not turtle.forward() then
                flip()
            end
        end
    end
    selectWheat()
    turtle.placeDown()
    os.sleep(0.05)
end
