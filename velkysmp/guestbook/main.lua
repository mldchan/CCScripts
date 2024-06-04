require("utils")
local json = require("json")
os.loadAPI("keyboard")

local guestbookEntries = {}

if fs.exists("gustbook.json") then
    guestbookEntries = json.decode(readFile("guestbook.json"))
end

local screen = "main"
local term_width, term_height = term.getSize()

function drawScreen()
    term.clear()

    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)

    if screen == "main" then
        if #guestbookEntries == 1 then
            term.setCursorPos(2, 2)
            term.write(guestbookEntries[1].title)
            term.setCursorPos(3, 4)
            term.write(guestbookEntries[1].content)
        elseif #guestbookEntries == 2 then
            term.setCursorPos(2, 2)
            term.write(guestbookEntries[1].title)
            term.setCursorPos(3, 3)
            term.write(guestbookEntries[1].content)

            term.setCursorPos(2, 5)
            term.write(guestbookEntries[2].title)
            term.setCursorPos(3, 6)
            term.write(guestbookEntries[2].content)
        elseif #guestbookEntries >= 3 then
            term.setCursorPos(2, 2)
            term.write(guestbookEntries[#guestbookEntries - 2].title)
            term.setCursorPos(3, 3)
            term.write(guestbookEntries[#guestbookEntries - 2].content)

            term.setCursorPos(2, 5)
            term.write(guestbookEntries[#guestbookEntries - 1].title)
            term.setCursorPos(3, 6)
            term.write(guestbookEntries[#guestbookEntries - 1].content)

            term.setCursorPos(2, 8)
            term.write(guestbookEntries[#guestbookEntries].title)
            term.setCursorPos(3, 9)
            term.write(guestbookEntries[#guestbookEntries].content)
        end

        term.setCursorPos(2, term_height - 1)
        term.write("[ Sign ]")
    elseif screen == "sign" then
        term.setCursorPos(2, 2)
        prettyWrite(term, "Please enter the title of your entry.")

        local title = keyboard.inputKeyboard()
        term.clear()

        term.setCursorPos(2, 2)
        prettyWrite(term, "Please enter the content of your entry.")

        local content = keyboard.inputKeyboard()
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
end
