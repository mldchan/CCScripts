require("utils")
local json = require("json")

local config = json.decode(readFile("config.json"))

local guestbookEntries = {}

if fs.exists("guestbook.json") then
    guestbookEntries = json.decode(readFile("guestbook.json"))
end

local screen = "main"
local termScreen = "idle"

local mon = peripheral.wrap(config.side)
local mon_width, mon_height = mon.getSize()

local managementIndex = 1

function drawScreen()
    mon.clear()

    mon.setBackgroundColor(colors.black)
    mon.setTextColor(colors.white)

    if screen == "main" then
        local entries_to_display = math.floor((mon_height - 3) / 3)
        local startIndex = math.max(1, #guestbookEntries - entries_to_display + 1)
        for index = startIndex, #guestbookEntries do
            local value = guestbookEntries[index]
            local y = (index - startIndex) * 3 + 2

            mon.setCursorPos(2, y)
            mon.write(value.title)
            mon.setCursorPos(3, y + 1)
            mon.write(value.content)
        end

        mon.setCursorPos(2, mon_height - 1)
        mon.write("[ Sign ]")

        -- mon.setCursorPos(11, mon_height - 1)
        -- mon.write("[ Management ]")

        local time = os.time()
        local dayUnfinished = os.day()
        local year = math.floor(dayUnfinished / 365) + 1
        --- make year always display in 4 digits e.g. 0002
        local month = math.floor((dayUnfinished - (year - 1) * 365) / 30) + 1
        local day = dayUnfinished - (year - 1) * 365 - (month - 1) * 30 + 1
        year = year + 2000
        year = string.format("%04d", year)
        month = string.format("%02d", month)
        day = string.format("%02d", day)
        local hours = math.floor(time)
        local minutes = math.floor((time - hours) * 100 * 0.6)
        hours = string.format("%02d", hours)
        minutes = string.format("%02d", minutes)

        mon.setCursorPos(1, 1)
        mon.write(tostring(year) ..
        "/" ..
        tostring(month) .. "/" .. tostring(day) .. " " .. tostring(hours) .. ":" .. tostring(minutes) .. " -- MC time!")
    elseif screen == "sign" then
        mon.setCursorPos(2, 2)
        prettyWrite(mon, "Please enter the title of your entry.")

        os.loadAPI("keyboard")
        local title = keyboard.inputKeyboard()
        os.unloadAPI("keyboard")
        mon.clear()

        mon.setCursorPos(2, 2)
        prettyWrite(mon, "Please enter the content of your entry.")

        os.loadAPI("keyboard")
        local content = keyboard.inputKeyboard()
        os.unloadAPI("keyboard")
        mon.clear()

        table.insert(guestbookEntries, {
            title = title,
            content = content
        })

        writeFile("guestbook.json", json.encode(guestbookEntries))
        screen = "main"
        drawScreen()
    -- elseif screen == "enter_password" then
    --     mon.setCursorPos(2, 2)
    --     prettyWrite(mon, "Please enter the password to access the management.")

    --     os.loadAPI("keyboard")
    --     local password = keyboard.inputKeyboard()
    --     os.unloadAPI("keyboard")

    --     if password == config.password then
    --         screen = "management"
    --         drawScreen()
    --     else
    --         screen = "main"
    --         drawScreen()
    --     end
    -- elseif screen == "management" then
        
    --     mon.setCursorPos(2, 2)
    --     prettyWrite(mon, "Guestbook Management")

    --     local entryTitle = guestbookEntries[managementIndex].title
    --     local entryContent = guestbookEntries[managementIndex].content
    --     mon.setCursorPos(2, 4)
    --     prettyWrite(mon, "Title: " .. entryTitle)
    --     mon.setCursorPos(2, 5)
    --     prettyWrite(mon, "Content: " .. entryContent)

    --     mon.setCursorPos(2, 7)
    --     prettyWrite(mon, "[ Delete ]")

    --     if managementIndex ~= 1 then
    --         mon.setCursorPos(2, 9)
    --         prettyWrite(mon, "[ Previous ]")
    --     end

    --     if managementIndex ~= #guestbookEntries - 1 then
    --         mon.setCursorPos(15, 9)
    --         prettyWrite(mon, "[ Next ]")
    --     end
    end
end

function drawTerm()
    term.clear()

    if termScreen == "idle" then
        term.setCursorPos(2, 2)
        term.write("[ Manage ]")
    elseif termScreen == "password" then
        term.setCursorPos(2, 2)
        prettyWrite(term, "To manage this guestbook, please enter the password.")
        local password = read("*")

        if password == config.password then
            termScreen = "management"
            drawTerm()
        else
            termScreen = "idle"

            term.setCursorPos(2, 4)
            term.setTextColor(colors.red)
            prettyWrite(term, "Incorrect password.")
            term.setTextColor(colors.white)
            drawTerm()
        end
    elseif termScreen == "management" then
        term.setCursorPos(2, 2)
        prettyWrite(term, "Guestbook Management")

        local entryTitle = guestbookEntries[managementIndex].title
        local entryContent = guestbookEntries[managementIndex].content
        term.setCursorPos(2, 4)
        prettyWrite(term, "Title: " .. entryTitle)
        term.setCursorPos(2, 5)
        prettyWrite(term, "Content: " .. entryContent)

        term.setCursorPos(2, 7)
        prettyWrite(term, "[ Delete ]")

        if managementIndex ~= 1 then
            term.setCursorPos(2, 9)
            prettyWrite(term, "[ Previous ]")
        end

        if managementIndex ~= #guestbookEntries - 1 then
            term.setCursorPos(15, 9)
            prettyWrite(term, "[ Next ]")
        end
    end
end

drawScreen()
drawTerm()

local timer = os.startTimer(1)

while true do
    event, p1, p2, p3, p4, p5 = os.pullEvent()
    if event == "monitor_touch" then
        if screen == "main" then
            if p2 > 1 and p2 < 10 and p3 == mon_height - 1 then
                screen = "sign"
                drawScreen()
            end

            if p2 > 11 and p2 < 23 and p3 == mon_height - 1 then
                screen = "enter_password"
                drawScreen()
            end
        -- elseif screen == "management" then

        --     if p2 > 1 and p2 < 13 and p3 == 7 then
        --         table.remove(guestbookEntries, managementIndex)
        --         writeFile("guestbook.json", json.encode(guestbookEntries))
        --         drawScreen()
        --     end

        --     if p2 > 1 and p2 < 14 and p3 == 9 then
        --         managementIndex = managementIndex - 1
        --         drawScreen()
        --     end

        --     if p2 > 14 and p2 < 22 and p3 == 9 then
        --         managementIndex = managementIndex + 1
        --         drawScreen()
        --     end

        end
    end

    if event == "mouse_click" then
        if termScreen == "idle" then
            if p2 > 1 and p2 < 13 and p3 == 2 then
                termScreen = "password"
                drawTerm()
            end
        elseif termScreen == "management" then
            if p2 > 1 and p2 < 13 and p3 == 7 then
                table.remove(guestbookEntries, managementIndex)
                writeFile("guestbook.json", json.encode(guestbookEntries))
                drawTerm()
            end

            if p2 > 1 and p2 < 14 and p3 == 9 then
                managementIndex = managementIndex - 1
                drawTerm()
            end

            if p2 > 14 and p2 < 22 and p3 == 9 then
                managementIndex = managementIndex + 1
                drawTerm()
            end
        end
    end

    if event == "timer" then
        if timer == p1 then
            drawScreen()

            timer = os.startTimer(1)
        end
    end
end
