
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
  mobs = con.sense()

  for index, value in ipairs(mobsList) do
    if not tableContains(mobsList, value) then
      table.insert(mobsList, value)
      print("Entity " .. value.displayName .. " has been added from the list.")
      con.say("Entity " .. value.name .. " has apeared!")
    end
  end

  for index, value in ipairs(mobsList) do
    if not tableContains(mobs, value) then
      table.remove(mobsList, index)
      print("Entity " .. value.displayName .. " has been removed from the list.")
      con.say("Entity " .. value.name .. " has dissapeared!")
    end
  end
end

