

local timer = os.time("utc")
local con = peripheral.wrap("back")

while true do
  os.queueEvent("tick")
  evt, p1, p2, p3, p4, p5 = os.pullEvent()

  if timer ~= os.time("utc") then
    timer = os.time("utc")

    if math.random(1000) == 1000 then
      local choices = {"Meow :3", "Meow", "Nya", "Nya :3"}
      con.say(choices[math.random(#choices)])
    end
  end
end

