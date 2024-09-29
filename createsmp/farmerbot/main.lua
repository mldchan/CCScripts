
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

local function main()
    flipped = false
    hitWall = false
    while true do
        if not turtle.forward() then
            if flipped then
                turtle.turnRight()
            else
                turtle.turnLeft()
            end
            hitWall = turtle.forward()
            if not hitWall then
                flipped = not flipped
            end
            if flipped and not hitWall then
                turtle.turnLeft()
            else
                turtle.turnRight()
            end
        end

        selectWheat()
        turtle.placeDown()
        os.sleep(0.05)
    end
end

main()
