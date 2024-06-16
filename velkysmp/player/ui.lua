
function getIgt()
    local time = os.time()
    local hours = math.floor(time)
    local minutes = math.floor((time - hours) * 100 * 0.6)
    hours = string.format("%02d", hours)
    minutes = string.format("%02d", minutes)
    return "In Game Time: " .. hours .. ":" .. minutes
end

per = peripheral.wrap("back")

canvas = per.canvas()

width, height = canvas.getSize()

timeText = canvas.addText({x = width - 76, y = 1}, getIgt())


while true do
    os.sleep(1)
    timeText.setText(getIgt())
end
