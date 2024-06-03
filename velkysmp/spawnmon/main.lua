VERSION = "1.03"

local utils = require("utils")
local json = require("json")

config_file = utils.readFile("config.json")
config = json.decode(config_file)

local mon = peripheral.wrap(config.side)
local mon_width, mon_height = mon.getSize()

local setting_show_online_first = false
local has_loaded = false
local api_parsed = {}
local show_settings = false
local small_text = false

function drawMainScreen()
  if show_settings then
    -- Create background
    mon.setBackgroundColor(colors.white)

    mon.setCursorPos(5, 5)
    mon.write("                              ")
    mon.setCursorPos(5, 6)
    mon.write("                              ")
    mon.setCursorPos(5, 7)
    mon.write("                              ")
    mon.setCursorPos(5, 8)
    mon.write("                              ")
    mon.setCursorPos(5, 9)
    mon.write("                              ")
    mon.setCursorPos(5, 10)
    mon.write("                              ")

    mon.setTextColor(colors.black)

    mon.setCursorPos(6, 4)
    mon.write("Settings")

    mon.setCursorPos(6, 6)
    mon.write("[")

    mon.setTextColor(colors.orange)

    if setting_show_online_first then
      mon.write("X")
    else
      mon.write(" ")
    end

    mon.setTextColor(colors.black)

    mon.write("] Show online players first")

    mon.setCursorPos(6, 7)
    mon.write("[")

    mon.setTextColor(colors.orange)

    if small_text then
      mon.write("X")
    else
      mon.write(" ")
    end

    mon.setTextColor(colors.black)

    mon.write("] Smaller text")

    mon.setCursorPos(6, 9)
    mon.setTextColor(colors.orange)
    mon.write("[ Close ]")
    mon.setTextColor(colors.black)
    mon.setBackgroundColor(colors.white)
  else
    if not has_loaded then
      local api_content = http.get("https://velkysmp-mon.vercel.app/api/get").readAll()
      api_parsed = json.decode(api_content)
      has_loaded = true
    end
    local api_sorted = {}

    if setting_show_online_first then
      for k, i in ipairs(api_parsed.players) do
        if i.online then
          table.insert(api_sorted, i)
        end
      end

      for k, i in ipairs(api_parsed.players) do
        if not i.online then
          table.insert(api_sorted, i)
        end
      end
    else
      api_sorted = api_parsed.players
    end

    if small_text then
      mon.setTextScale(0.5)
    else
      mon.setTextScale(1)
    end

    mon_width, mon_height = mon.getSize()

    mon.clear()
    mon.setCursorPos(1, 1)
    mon.write("Akatsuki's VelkySMP monitor - since 2024/02/25!")

    mon.setCursorPos(1, 3)
    mon.write("Top players by online and playtime")

    local items_count = mon_height - 5
    for k, v in ipairs(api_sorted) do
      if k > items_count then
        break
      end

      mon.setCursorPos(2, 4 + k)
      mon.write(k .. ". " .. v.name)
      mon.setCursorPos(mon_width - 20, 4 + k)
      mon.write(v.humantime)

      if v.online then
        mon.setCursorPos(mon_width - 5, 4 + k)
        mon.write("Online")
      end
    end

    mon.setCursorPos(1, mon_height)
    mon.write("Akatsuki ComputerCraft Monitor v" .. VERSION)

    mon.setCursorPos(40, mon_height)
    mon.write("Settings")
  end
end

mon.clear()

mon.setCursorPos(1, 1)
mon.write("Akatsuki's VelkySMP monitor - since 2024/02/25!")

mon.clear()

mon.setCursorPos(2, 3)
mon.write("Refreshing... this may take a while")

drawMainScreen()

while true do
  event, p1, p2, p3, p4, p5 = os.pullEvent()
  if event == "monitor_touch" then
    if p2 > 40 and p2 < 47 and p3 == mon_height then
      show_settings = not show_settings
      print("show settings")
      drawMainScreen()
    end

    if show_settings then
      if p2 == 7 and p3 == 6 then
        setting_show_online_first = not setting_show_online_first
        drawMainScreen()
      end

      if p2 == 7 and p3 == 7 then
        small_text = not small_text
        drawMainScreen()
      end

      if p2 >= 6 and p2 <= 13 and p3 == 9 then
        show_settings = false
        drawMainScreen()
      end
    end
  elseif event == "monitor_resize" then
    drawMainScreen()
  end
end
