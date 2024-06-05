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
	x = x / 2 - #Text / 2
	term.setCursorPos(x, Line)
	if Color then setCol(term, Color, BkgColor) end
	term.write(Text)
	if NextLine then
		term.setCursorPos(1, NextLine)
	end
	if Color then setCol(term, Color, BkgColor) end
	return true
end

function printA(term, Text, xx, yy, NextLine, Color, BkgColor) -- print anywhere
	term.setCursorPos(xx, yy)
	if Color then setCol(term, Color, BkgColor) end
	term.write(Text)
	if NextLine then
		term.setCursorPos(1, NextLine)
	end
	if Color then setCol(term, Color, BkgColor) end
	return true
end

function drawBox(term, StartX, lengthX, StartY, lengthY, Text, Color, BkgColor) -- does what is says on the tin.
	local x, y = term.getSize()
	if Color then setCol(term, Color, BkgColor) end
	if not Text then Text = "*" end
	lengthX = lengthX - 1
	lengthY = lengthY - 1
	EndX = StartX + lengthX
	EndY = StartY + lengthY
	term.setCursorPos(StartX, StartY)
	term.write(string.rep(Text, lengthX))
	term.setCursorPos(StartX, EndY)
	term.write(string.rep(Text, lengthX))
	for i = StartY, EndY do
		term.setCursorPos(StartX, i)
		term.write(Text)
		term.setCursorPos(EndX, i)
		term.write(Text)
	end
	setCol(term, Color, BkgColor)
	return true
end

-- Start Code:
kbtc = "white"
kbbc = "blue"
keyText = "black"
keyBack = "white"
sKeyVer = 1.1
keyOutput = {}
capsToggle = false

function drawKeyboard(term)
	tRow1 = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "(", ")", "F1", " BACKSPACE", }
	tRow2 = { "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", ":", "_", "F2", " ENTER/ OK", }
	tRow3 = { "A", "S", "D", "F", "G", "H", "J", "K", "L", "#", ";", "=", "F3", " CAPS LOCK", }
	tRow4 = { "/", "Z", "X", "C", "V", "B", "N", "M", "@", "~", "'", "+", "F4", " >DannySMc", }
	tRow5 = { "[", "]", "{", "}", "&", "$", "%", "-", "*", "!", "?", ".", "F5", " >Akatsuki", }

	local intX, intY = term.getCursorPos()
	drawBox(term, 8, 38, 11, 3, " ", kbtc, kbbc)
	drawBox(term, 8, 38, 13, 7, " ", kbtc, kbbc)
	drawBox(term, 9, 36, 12, 1, " ", keyText, keyBack)
	drawBox(term, 9, 36, 14, 2, " ", keyText, keyBack)
	drawBox(term, 9, 36, 16, 2, " ", keyText, keyBack)
	drawBox(term, 9, 36, 18, 1, " ", keyText, keyBack)
	printA("SPACE", 23, 19, false, keyText, keyBack)
	setCol(term, keyText, keyBack)

	i = 9
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
	resetCol(term)
	printC(term, "   Keyboard (Ver: " .. tostring(sKeyVer) .. ") - DannySMc", 13, 1, "red", kbbc)
	setCol(term, "black", "white")
	term.setCursorPos(9, 12)
	term.write(": ")
	resetCol(term)
	setCol(term, "black", "white")
	term.setCursorPos(11, 12)
end

function inputKeyboard(term)
	drawKeyboard()
	i = 11
	while true do
		local args = { os.pullEvent() }
		if args[1] == "mouse_click" then
			-- Check Y value first!
			if args[4] == 14 then
				-- Check X value
				if args[3] == 9 then
					addCharacter(term, tRow1[1])
				elseif args[3] == 11 then
					addCharacter(term, tRow1[2])
				elseif args[3] == 13 then
					addCharacter(term, tRow1[3])
				elseif args[3] == 15 then
					addCharacter(term, tRow1[4])
				elseif args[3] == 17 then
					addCharacter(term, tRow1[5])
				elseif args[3] == 19 then
					addCharacter(term, tRow1[6])
				elseif args[3] == 21 then
					addCharacter(term, tRow1[7])
				elseif args[3] == 23 then
					addCharacter(term, tRow1[8])
				elseif args[3] == 25 then
					addCharacter(term, tRow1[9])
				elseif args[3] == 27 then
					addCharacter(term, tRow1[10])
				elseif args[3] == 29 then
					addCharacter(term, tRow1[11])
				elseif args[3] == 31 then
					addCharacter(term, tRow1[12])
				elseif args[3] >= 33 and args[3] <= 34 then
					return specialKeys(1)
				elseif args[3] >= 36 and args[3] <= 44 then
					backSpace(term)
				end
			elseif args[4] == 15 then
				-- check x value
				if args[3] == 9 then
					addCharacter(term, tRow2[1])
				elseif args[3] == 11 then
					addCharacter(term, tRow2[2])
				elseif args[3] == 13 then
					addCharacter(term, tRow2[3])
				elseif args[3] == 15 then
					addCharacter(term, tRow2[4])
				elseif args[3] == 17 then
					addCharacter(term, tRow2[5])
				elseif args[3] == 19 then
					addCharacter(term, tRow2[6])
				elseif args[3] == 21 then
					addCharacter(term, tRow2[7])
				elseif args[3] == 23 then
					addCharacter(term, tRow2[8])
				elseif args[3] == 25 then
					addCharacter(term, tRow2[9])
				elseif args[3] == 27 then
					addCharacter(term, tRow2[10])
				elseif args[3] == 29 then
					addCharacter(term, tRow2[11])
				elseif args[3] == 31 then
					addCharacter(term, tRow2[12])
				elseif args[3] >= 33 and args[3] <= 34 then
					return specialKeys(2)
				elseif args[3] >= 36 and args[3] <= 44 then
					return enter_ok()
				end
			elseif args[4] == 16 then
				-- check x value
				if args[3] == 9 then
					addCharacter(term, tRow3[1])
				elseif args[3] == 11 then
					addCharacter(term, tRow3[2])
				elseif args[3] == 13 then
					addCharacter(term, tRow3[3])
				elseif args[3] == 15 then
					addCharacter(term, tRow3[4])
				elseif args[3] == 17 then
					addCharacter(term, tRow3[5])
				elseif args[3] == 19 then
					addCharacter(term, tRow3[6])
				elseif args[3] == 21 then
					addCharacter(term, tRow3[7])
				elseif args[3] == 23 then
					addCharacter(term, tRow3[8])
				elseif args[3] == 25 then
					addCharacter(term, tRow3[9])
				elseif args[3] == 27 then
					addCharacter(term, tRow3[10])
				elseif args[3] == 29 then
					addCharacter(term, tRow3[11])
				elseif args[3] == 31 then
					addCharacter(term, tRow3[12])
				elseif args[3] >= 33 and args[3] <= 34 then
					return specialKeys(3)
				elseif args[3] >= 36 and args[3] <= 44 then
					caps_lock(term)
				end
			elseif args[4] == 17 then
				-- check x value
				if args[3] == 9 then
					addCharacter(term, tRow4[1])
				elseif args[3] == 11 then
					addCharacter(term, tRow4[2])
				elseif args[3] == 13 then
					addCharacter(term, tRow4[3])
				elseif args[3] == 15 then
					addCharacter(term, tRow4[4])
				elseif args[3] == 17 then
					addCharacter(term, tRow4[5])
				elseif args[3] == 19 then
					addCharacter(term, tRow4[6])
				elseif args[3] == 21 then
					addCharacter(term, tRow4[7])
				elseif args[3] == 23 then
					addCharacter(term, tRow4[8])
				elseif args[3] == 25 then
					addCharacter(term, tRow4[9])
				elseif args[3] == 27 then
					addCharacter(term, tRow4[10])
				elseif args[3] == 29 then
					addCharacter(term, tRow4[11])
				elseif args[3] == 31 then
					addCharacter(term, tRow4[12])
				elseif args[3] >= 33 and args[3] <= 34 then
					return specialKeys(4)
				elseif args[3] >= 36 and args[3] <= 44 then
					extraInfo()
				end
			elseif args[4] == 18 then
				-- check x value
				if args[3] == 9 then
					addCharacter(term, tRow5[1])
				elseif args[3] == 11 then
					addCharacter(term, tRow5[2])
				elseif args[3] == 13 then
					addCharacter(term, tRow5[3])
				elseif args[3] == 15 then
					addCharacter(term, tRow5[4])
				elseif args[3] == 17 then
					addCharacter(term, tRow5[5])
				elseif args[3] == 19 then
					addCharacter(term, tRow5[6])
				elseif args[3] == 21 then
					addCharacter(term, tRow5[7])
				elseif args[3] == 23 then
					addCharacter(term, tRow5[8])
				elseif args[3] == 25 then
					addCharacter(term, tRow5[9])
				elseif args[3] == 27 then
					addCharacter(term, tRow5[10])
				elseif args[3] == 29 then
					addCharacter(term, tRow5[11])
				elseif args[3] == 31 then
					addCharacter(term, tRow5[12])
				elseif args[3] >= 33 and args[3] <= 34 then
					return specialKeys(5)
				elseif args[3] >= 36 and args[3] <= 44 then
					instructions()
				end
			elseif args[4] == 19 then
				-- check x value
				if args[3] >= 23 and args[3] <= 27 then
					addCharacter(term, " ")
				end
			end
		end
	end
end

function addCharacter(term, charInput)
	if charInput == " " then
		setCol(term, "black", "white")
		table.insert(keyOutput, charInput)
		term.setCursorPos(i, 12)
		term.write(charInput)
		i = i + 1
		resetCol(term)
	else
		if capsToggle == true then
			setCol(term, "black", "white")
			table.insert(keyOutput, string.upper(charInput))
			term.setCursorPos(i, 12)
			term.write(string.upper(charInput))
			i = i + 1
			resetCol(term)
		elseif capsToggle == false then
			setCol(term, "black", "white")
			table.insert(keyOutput, string.lower(charInput))
			term.setCursorPos(i, 12)
			term.write(string.lower(charInput))
			i = i + 1
			resetCol(term)
		end
	end
end

function backSpace(term)
	setCol(term, "black", "white")
	table.remove(keyOutput)
	i = i - 1
	term.setCursorPos(i, 12)
	term.write(" ")
	term.setCursorPos(i, 12)
	resetCol(term)
end

function caps_lock(term)
	if capsToggle == true then
		term.setCursorPos(36, 16)
		setCol(term, "black", "white")
		term.write("CAPS LOCK")
		capsToggle = false
	elseif capsToggle == false then
		term.setCursorPos(36, 16)
		setCol(term, "red", "white")
		term.write("CAPS LOCK")
		capsToggle = true
	end
end

function enter_ok()
	returnString = table.concat(keyOutput)
	return returnString
end

function specialKeys(nKey)
	return nKey
end
