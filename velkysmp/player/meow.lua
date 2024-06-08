

local timer = os.time("utc")
local con = peripheral.wrap("back")

while true do
  os.queueEvent("tick")
  local evt, p1, p2, p3, p4, p5 = os.pullEvent()

  if timer ~= os.time("utc") then
    timer = os.time("utc")

    local random = math.random(1000)
    print("Random value: ", random)
    if random == 1000 then
      local choices = {"Meow :3", "Meow", "Nya", "Nya :3"}
      con.say(choices[math.random(#choices)])
    end
  end
end

