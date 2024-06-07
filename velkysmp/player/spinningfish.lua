

local con = peripheral.wrap("back")
local can = con.canvas3d()
can = can.create({x=0,y=1,z=0})

fish = can.addItem({x=0,y=0,z=0}, "minecraft:fish")

local rot = 0

while true do
  os.sleep(0.05)
  rot = rot + 36
  fish.setRotation({x=0,y=rot,z=0})
end

