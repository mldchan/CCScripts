
local con = peripheral.wrap("back")

local mobsList = {}

function tableContains(tabl, el)
    for _, value in pairs(tabl) do
        if value == el then
            return true
        end
    end
    return false
end

while true do
  os.sleep(1)
  local mobs = con.sense()

  for index, value in ipairs(mobs) do
    con.tell("Mob: " .. value.uuid)
  end

end

