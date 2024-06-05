-- On-Screen Keyboard (Terminal)
-- Created By DannySMc
-- Enhanced by Akatsuki2555
-- Platform: Lua Virtual Machine

-- ComputerCraftScripts
-- Copyright (C) 2024  Akatsuki

-- This program is free software: you can redistribute it and/or modify it under the terms of the
-- GNU General Public License as published by the Free Software Foundation, either version 3 of
-- the License, or (at your option) any later version.

-- This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
-- even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License along with this program.
-- If not, see <https://www.gnu.org/licenses/>.

-- Common Draw Functions
function cs(term)
    term.clear()
    term.setCursorPos(1, 1)
    return
end

function setCol(term, textColour, backgroundColour)
    if textColour and backgroundColour then
        if term.isColour() then
            term.setTextColour(colours[textColour])
            term.setBackgroundColour(colours[backgroundColour])
            return true
        else
            return false
        end
    else
        return false
    end
end

function resetCol(term)
    if term.isColour then
        term.setTextColour(colours.white)
        term.setBackgroundColour(colours.black)
        return true
    else
        return false
    end
end

-- Print Functions
function printC(term, Text, Line, NextLine, Color, BkgColor) -- print centered
    local x, y = term.getSize()
    x = math.floor(x / 2 - #Text / 2)
    term.setCursorPos(x, Line)
    if Color then setCol(term, Color, BkgColor) end
    term.write(Text)
    if NextLine then
        term.setCursorPos(1, NextLine)
    end
    if Color then resetCol(term) end
    return true
end

function printA(term, Text, xx, yy, NextLine, Color, BkgColor) -- print anywhere
    term.setCursorPos(xx, yy)
    if Color then setCol(term, Color, BkgColor) end
    term.write(Text)
    if NextLine then
        term.setCursorPos(1, NextLine)
    end
    if Color then resetCol(term) end
    return true
end

function drawBox(term, StartX, lengthX, StartY, lengthY, Text, Color, BkgColor) -- does what is says on the tin.
    if Color then setCol(term, Color, BkgColor) end
    if not Text then Text = "*" end
    lengthX = lengthX - 1
    lengthY = lengthY - 1
    local EndX = StartX + lengthX
    local EndY = StartY + lengthY
    term.setCursorPos(StartX, StartY)
    term.write(string.rep(Text, lengthX + 1))
    term.setCursorPos(StartX, EndY)
    term.write(string.rep(Text, lengthX + 1))
    for i = StartY + 1, EndY - 1 do
        term.setCursorPos(StartX, i)
        term.write(Text)
        term.setCursorPos(EndX, i)
        term.write(Text)
    end
    if Color then resetCol(term) end
    return true
end

-- Start Code:
local kbtc = "white"
local kbbc = "blue"
local keyText = "black"
local keyBack = "white"
local sKeyVer = 1.1
local keyOutput = {}
local capsToggle = false

function drawKeyboard(term)
    local tRow1 = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "(", ")", "F1", " BACKSPACE", }
    local tRow2 = { "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", ":", "_", "F2", " ENTER/ OK", }
    local tRow3 = { "A", "S", "D", "F", "G", "H", "J", "K", "L", "#", ";", "=", "F3", " CAPS LOCK", }
    local tRow4 = { "/", "Z", "X", "C", "V", "B", "N", "M", "@", "~", "'", "+", "F4", " >DannySMc", }
    local tRow5 = { "[", "]", "{", "}", "&", "$", "%", "-", "*", "!", "?", ".", "F5", " >Akatsuki", }

    drawBox(term, 8, 38, 11, 3, " ", kbtc, kbbc)
    drawBox(term, 8, 38, 13, 7, " ", kbtc, kbbc)
    drawBox(term, 9, 36, 12, 1, " ", keyText, keyBack)
    drawBox(term, 9, 36, 14, 2, " ", keyText, keyBack)
    drawBox(term, 9, 36, 16, 2, " ", keyText, keyBack)
    drawBox(term, 9, 36, 18, 1, " ", keyText, keyBack)
    printA(term, "SPACE", 23, 19, false, keyText, keyBack)
    resetCol(term)

    local i = 9
    for _, v in ipairs(tRow1) do
        term.setCursorPos(i, 14)
        term.write(v)
        i = i + 2
    end
    i = 9
    for _, v in ipairs(tRow2) do
        term.setCursorPos(i, 15)
        term.write(v)
        i = i + 2
    end
    i = 9
    for _, v in ipairs(tRow3) do
        term.setCursorPos(i, 16)
        term.write(v)
        i = i + 2
    end
    i = 9
    for _, v in ipairs(tRow4) do
        term.setCursorPos(i, 17)
        term.write(v)
        i = i + 2
    end
    i = 9
    for _, v in ipairs(tRow5) do
        term.setCursorPos(i, 18)
        term.write(v)
        i = i + 2
    end
    printC(term, "   Keyboard (Ver: " .. tostring(sKeyVer) .. ") - DannySMc", 13, nil, "red", kbbc)
    setCol(term, "black", "white")
    term.setCursorPos(9, 12)
    term.write(": ")
    resetCol(term)
    setCol(term, "black", "white")
    term.setCursorPos(11, 12)
end

function inputKeyboard(term)
    drawKeyboard(term)
    local i = 11
    while true do
        local args = { os.pullEvent() }
        if args[1] == "mouse_click" then
            -- Check Y value first!
            if args[4] == 14 then
                -- Check X value
                if args[3] == 9 then
                    addCharacter(term, tRow1[1], i)
                elseif args[3] == 11 then
                    addCharacter(term, tRow1[2], i)
                elseif args[3] == 13 then
                    addCharacter(term, tRow1[3], i)
                elseif args[3] == 15 then
                    addCharacter(term, tRow1[4], i)
                elseif args[3] == 17 then
                    addCharacter(term, tRow1[5], i)
                elseif args[3] == 19 then
                    addCharacter(term, tRow1[6], i)
                elseif args[3] == 21 then
                    addCharacter(term, tRow1[7], i)
                elseif args[3] == 23 then
                    addCharacter(term, tRow1[8], i)
                elseif args[3] == 25 then
                    addCharacter(term, tRow1[9], i)
                elseif args[3] == 27 then
                    addCharacter(term, tRow1[10], i)
                elseif args[3] == 29 then
                    addCharacter(term, tRow1[11], i)
                elseif args[3] == 31 then
                    addCharacter(term, tRow1[12], i)
                elseif args[3] >= 33 and args[3] <= 34 then
                    return specialKeys(1)
                elseif args[3] >= 36 and args[3] <= 44 then
                    backSpace(term, i)
                end
            elseif args[4] == 15 then
                -- check x value
                if args[3] == 9 then
                    addCharacter(term, tRow2[1], i)
                elseif args[3] == 11 then
                    addCharacter(term, tRow2[2], i)
                elseif args[3] == 13 then
                    addCharacter(term, tRow2[3], i)
                elseif args[3] == 15 then
                    addCharacter(term, tRow2[4], i)
                elseif args[3] == 17 then
                    addCharacter(term, tRow2[5], i)
                elseif args[3] == 19 then
                    addCharacter(term, tRow2[6], i)
                elseif args[3] == 21 then
                    addCharacter(term, tRow2[7], i)
                elseif args[3] == 23 then
                    addCharacter(term, tRow2[8], i)
                elseif args[3] == 25 then
                    addCharacter(term, tRow2[9], i)
                elseif args[3] == 27 then
                    addCharacter(term, tRow2[10], i)
                elseif args[3] == 29 then
                    addCharacter(term, tRow2[11], i)
                elseif args[3] == 31 then
                    addCharacter(term, tRow2[12], i)
                elseif args[3] >= 33 and args[3] <= 34 then
                    return specialKeys(2)
                elseif args[3] >= 36 and args[3] <= 44 then
                    enterKey()
                end
            elseif args[4] == 16 then
                -- Check X value
                if args[3] == 9 then
                    addCharacter(term, tRow3[1], i)
                elseif args[3] == 11 then
                    addCharacter(term, tRow3[2], i)
                elseif args[3] == 13 then
                    addCharacter(term, tRow3[3], i)
                elseif args[3] == 15 then
                    addCharacter(term, tRow3[4], i)
                elseif args[3] == 17 then
                    addCharacter(term, tRow3[5], i)
                elseif args[3] == 19 then
                    addCharacter(term, tRow3[6], i)
                elseif args[3] == 21 then
                    addCharacter(term, tRow3[7], i)
                elseif args[3] == 23 then
                    addCharacter(term, tRow3[8], i)
                elseif args[3] == 25 then
                    addCharacter(term, tRow3[9], i)
                elseif args[3] == 27 then
                    addCharacter(term, tRow3[10], i)
                elseif args[3] == 29 then
                    addCharacter(term, tRow3[11], i)
                elseif args[3] == 31 then
                    addCharacter(term, tRow3[12], i)
                elseif args[3] >= 33 and args[3] <= 34 then
                    return specialKeys(3)
                elseif args[3] >= 36 and args[3] <= 44 then
                    capsToggle = not capsToggle
                end
            elseif args[4] == 17 then
                -- Check X value
                if args[3] == 9 then
                    addCharacter(term, tRow4[1], i)
                elseif args[3] == 11 then
                    addCharacter(term, tRow4[2], i)
                elseif args[3] == 13 then
                    addCharacter(term, tRow4[3], i)
                elseif args[3] == 15 then
                    addCharacter(term, tRow4[4], i)
                elseif args[3] == 17 then
                    addCharacter(term, tRow4[5], i)
                elseif args[3] == 19 then
                    addCharacter(term, tRow4[6], i)
                elseif args[3] == 21 then
                    addCharacter(term, tRow4[7], i)
                elseif args[3] == 23 then
                    addCharacter(term, tRow4[8], i)
                elseif args[3] == 25 then
                    addCharacter(term, tRow4[9], i)
                elseif args[3] == 27 then
                    addCharacter(term, tRow4[10], i)
                elseif args[3] == 29 then
                    addCharacter(term, tRow4[11], i)
                elseif args[3] == 31 then
                    addCharacter(term, tRow4[12], i)
                elseif args[3] >= 33 and args[3] <= 34 then
                    return specialKeys(4)
                elseif args[3] >= 36 and args[3] <= 44 then
                    print("DannySMc")
                end
            elseif args[4] == 18 then
                -- Check X value
                if args[3] == 9 then
                    addCharacter(term, tRow5[1], i)
                elseif args[3] == 11 then
                    addCharacter(term, tRow5[2], i)
                elseif args[3] == 13 then
                    addCharacter(term, tRow5[3], i)
                elseif args[3] == 15 then
                    addCharacter(term, tRow5[4], i)
                elseif args[3] == 17 then
                    addCharacter(term, tRow5[5], i)
                elseif args[3] == 19 then
                    addCharacter(term, tRow5[6], i)
                elseif args[3] == 21 then
                    addCharacter(term, tRow5[7], i)
                elseif args[3] == 23 then
                    addCharacter(term, tRow5[8], i)
                elseif args[3] == 25 then
                    addCharacter(term, tRow5[9], i)
                elseif args[3] == 27 then
                    addCharacter(term, tRow5[10], i)
                elseif args[3] == 29 then
                    addCharacter(term, tRow5[11], i)
                elseif args[3] == 31 then
                    addCharacter(term, tRow5[12], i)
                elseif args[3] >= 33 and args[3] <= 34 then
                    return specialKeys(5)
                elseif args[3] >= 36 and args[3] <= 44 then
                    print("Akatsuki")
                end
            end
        elseif args[1] == "char" then
            addCharacter(term, args[2], i)
        end
    end
end

function addCharacter(term, char, cursorPos)
    if capsToggle then
        char = string.upper(char)
    end
    table.insert(keyOutput, char)
    term.setCursorPos(cursorPos, 12)
    term.write(char)
    term.setCursorPos(cursorPos + 1, 12)
end

function backSpace(term, cursorPos)
    if #keyOutput > 0 then
        table.remove(keyOutput)
        term.setCursorPos(cursorPos - 1, 12)
        term.write(" ")
        term.setCursorPos(cursorPos - 1, 12)
    end
end

function specialKeys(row)
    if row == 1 then
        print("F1")
    elseif row == 2 then
        print("F2")
    elseif row == 3 then
        print("F3")
    elseif row == 4 then
        print("F4")
    elseif row == 5 then
        print("F5")
    end
end

function enterKey()
    print("Enter")
    local input = table.concat(keyOutput)
    return input
end

local term = term.current()
cs(term)
printC(term, "On-Screen Keyboard", 1, 3, "red", "blue")
printC(term, "Welcome to the on-screen keyboard. Click to type.", 2, 4, "yellow", "blue")
drawKeyboard(term)
local userInput = inputKeyboard(term)
print("User Input: " .. userInput)
