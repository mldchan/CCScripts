
local con = peripheral.wrap("back")
local can = con.canvas()

can.clear()

local ents = can.addText({x=4,y=4}, "")

while true do
  os.sleep(1)

  local scan = con.sense()
  local scanReady = {}

  for _, value in pairs(scan) do
    if scanReady[value.name] == nil then
      scanReady[value.name] = 1
    else
      scanReady[value.name] = scanReady[value.name] + 1
    end
  end

  local message = ""

  for key, value in pairs(scanReady) do
    message = message .. key .. " x" .. tostring(value) .. "\n"
  end

  ents.setText(message)
end


