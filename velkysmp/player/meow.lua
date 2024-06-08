

local timer = os.time("utc")
local con = peripheral.wrap("back")

while true do
  os.queueEvent("tick")
  local evt, p1, p2, p3, p4, p5 = os.pullEvent()

  if timer ~= os.time("utc") then
    timer = os.time("utc")

    local random = math.random(100)
    print("Random value: ", random)
    if random == 100 then
      local choices1 = {"Meow", "Nya", "Mrow", "Mroow", "Mraow"}
      local choices2 = {"~", ""}
      local choices3 = {":3", "", ":3c", ">:3"}

      local msg = choices1[math.random(#choices1)] .. choices2[math.random(#choices2)] .. " " .. choices3[math.random(#choices3)]

      con.say(msg)
    end
  end
end

