
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
    flipCompletely = false
    while true do
        if not turtle.forward() then
            if flipped then
                turtle.turnRight()
            else
                turtle.turnLeft()
            end
            if not turtle.forward() then
                flipCompletely = true
            end
            if flipped then
                if flipCompletely then
                    turtle.turnRight()
                else
                    turtle.turnLeft()
                end
            else
                if flipCompletely then
                    turtle.turnLeft()
                else
                    turtle.turnRight()
                end
            end
            flipped = not flipped
        end

        selectWheat()
        turtle.placeDown()
        os.sleep(0.05)
    end
end

main()
