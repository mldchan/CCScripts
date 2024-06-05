require("utils")
local json = require("json")

local guestbookEntries = {}

if fs.exists("guestbook.json") then
    guestbookEntries = json.decode(readFile("guestbook.json"))
end

local screen = "main"
local term_width, term_height = term.getSize()

function drawScreen()
    term.clear()

    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)

    if screen == "main" then
        local entries_to_display = math.floor((term_height - 3) / 3)
        local startIndex = math.max(1, #guestbookEntries - entries_to_display + 1)
        for index = startIndex, #guestbookEntries do
            local value = guestbookEntries[index]
            local y = (index - startIndex) * 3 + 2

            term.setCursorPos(2, y)
            term.write(value.title)
            term.setCursorPos(3, y + 1)
            term.write(value.content)
        end

        term.setCursorPos(2, term_height - 1)
        term.write("[ Sign ]")

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

        term.setCursorPos(1, 1)
        term.write(tostring(year) .. "/" .. tostring(month) .. "/" .. tostring(day) .. " " .. tostring(hours) .. ":" .. tostring(minutes) .. " -- MC time!")
    elseif screen == "sign" then
        term.setCursorPos(2, 2)
        prettyWrite(term, "Please enter the title of your entry.")

        os.loadAPI("keyboard")
        local title = keyboard.inputKeyboard()
        os.unloadAPI("keyboard")
        term.clear()

        term.setCursorPos(2, 2)
        prettyWrite(term, "Please enter the content of your entry.")

        os.loadAPI("keyboard")
        local content = keyboard.inputKeyboard()
        os.unloadAPI("keyboard")
        term.clear()

        table.insert(guestbookEntries, {
            title = title,
            content = content
        })

        writeFile("guestbook.json", json.encode(guestbookEntries))
        screen = "main"
        drawScreen()
    end
end

drawScreen()

local timer = os.startTimer(1)

while true do
    event, p1, p2, p3, p4, p5 = os.pullEvent()
    if event == "mouse_click" then
        if screen == "main" then
            if p2 > 1 and p2 < 10 and p3 == term_height - 1 then
                screen = "sign"
                drawScreen()
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
