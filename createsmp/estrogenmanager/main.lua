print("Hello from main!")

local mon = peripheral.wrap("bottom")
local input = peripheral.wrap("create:fluid_tank_0")
local output1 = peripheral.wrap("create:fluid_tank_1")
local output2 = peripheral.wrap("create:spout_0")

function drawRect(x, y, w, h)
    -- Draw a rectangle (border only)
    mon.setBackgroundColor(colors.white)
    mon.setCursorPos(x, y)
    for i = 1, w + 1 do
        mon.write(" ")
    end

    for i = 1, h do
        mon.setCursorPos(x, y + i)
        mon.write(" ")
        mon.setCursorPos(x + w, y + i)
        mon.write(" ")
    end

    for i = 1, w do
        mon.setCursorPos(x + i, y + h)
        mon.write(" ")
    end

    mon.setBackgroundColor(colors.black)
end

function drawRectF(x, y, w, h, color)
    -- Draw a rectangle (filled)
    mon.setBackgroundColor(color)
    for i = 1, h do
        mon.setCursorPos(x, y + i)
        for j = 1, w do
            mon.write(" ")
        end
    end
    mon.setBackgroundColor(colors.black)
end

function getFluidLevel(periph)
    local level = 0

    for _, tank in pairs(periph.tanks()) do
        level = level + tank.amount
    end

    return level
end

function getElement(periph)
    local tanks = periph.tanks()
    local counts = {}

    for _, tank in pairs(tanks) do
        local name = tank.name
        counts[name] = (counts[name] or 0) + tank.amount
    end

    local mostFilled = nil
    local mostFilledAmount = 0

    for name, amount in pairs(counts) do
        if amount > mostFilledAmount then
            mostFilledAmount = amount
            mostFilled = name
        end
    end

    if mostFilled == nil then
        return "empty"
    else
        return mostFilled
    end
end

mon.clear()

while true do
    os.queueEvent("tick")
    local event, p1, p2, p3, p4, p5 = os.pullEvent()

    -- mon.setCursorPos(1, 1)
    -- mon.write("Input: " .. getFluidLevel(input) .. " of " .. getElement(input))
    -- mon.setCursorPos(1, 2)
    -- mon.write("Output 1: " .. getFluidLevel(output1) .. " of " .. getElement(output1))
    -- mon.setCursorPos(1, 3)
    -- mon.write("Output 2: " .. getFluidLevel(output2) .. " of " .. getElement(output2))

    mon.setCursorPos(2, 2)
    mon.write("Input")

    drawRect(2, 4, 5, 6)

    -- Capacity is 8000 per tank
    height = getFluidLevel(input) / 8000 * 6
    drawRectF(2, 4 + 6 - height, 5, height, colors.yellow)

    mon.setCursorPos(2, 12)
    percentage = math.floor(getFluidLevel(input) / 24000 * 100)
    mon.write(percentage .. "%")

    mon.setCursorPos(9, 2)
    mon.write("Output")
    drawRect(9, 4, 5, 6)
    height = getFluidLevel(output1) + getFluidLevel(output2)
    height = height / 17000 * 6

    drawRectF(9, 4 + 6 - height, 5, height, colors.blue)

    mon.setCursorPos(9, 12)
    percentage = math.floor((getFluidLevel(output1) + getFluidLevel(output2)) / 17000 * 100 + 0.5)
    mon.write(percentage .. "%")
end
