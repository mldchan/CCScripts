
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
    local flipped = false
    while true do
        if not turtle.forward() then
            if flipped then
                turtle.turnRight()
                if not turtle.forward() then
                    turtle.turnRight()
                else
                    turtle.turnRight()
                    flipped = false
                end
            else
                turtle.turnLeft()
                if not turtle.forward() then
                    turtle.turnLeft()
                else
                    turtle.turnLeft()
                    flipped = true
                end
            end
        end

        selectWheat()
        turtle.placeDown()
        os.sleep(0.05)
    end
end

main()
