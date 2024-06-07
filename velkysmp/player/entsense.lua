
local con = peripheral.wrap("back")

local mobsList = {}
local ignoreList = {"Cow", "Pig", "Chicken", "Zombie", "Skeleton", "Horse", "Creeper"}

function tableContains(tabl, el)
    for _, value in pairs(tabl) do
        if value.id == el.id then
            return true
        end
    end
    return false
end

while true do
  os.sleep(1)
  local mobs = con.sense()

  for index, value in ipairs(mobs) do
    local el = {
      id = value.id,
      displayName = value.displayName
    }

    if not tableContains(mobsList, el) then
      table.insert(mobsList, el)
      con.say("Hello, " .. el.displayName .. "!")
    end
  end

  for index, value in ipairs(mobsList) do
    if not tableContains(mobs, value) then
      table.remove(mobsList, index)
      con.say("Goodbye, " .. value.displayName .. "!")
    end
  end

end

