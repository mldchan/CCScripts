
function readFile(filename)
    -- check if file exists, if not, return empty string
    if not fs.exists(filename) then
        return ""
    end

    file = fs.open(filename, "r")
    content = file.readAll()
    file.close()
    return content
end

function writeFile(filename, data)
    file = fs.open(filename, "w")
    file.write(data)
    file.close()
end

function prettyWrite(term, text)
    -- Make it wrap too
    local width, height = term.getSize()
    local x, y = term.getCursorPos()
    local lines = {}
    local line = ""
    for word in text:gmatch("%S+") do
        if #line + #word + 1 > width then
            table.insert(lines, line)
            line = ""
        end
        line = line .. word .. " "
    end
    table.insert(lines, line)
    for i, line in ipairs(lines) do
        term.setCursorPos(x, y + i - 1)
        term.write(line)
    end
end

function prompt(prompt)
    local content = ""
    
    while true do
        term.clearLine()
        local pos = {term.getCursorPos()}
        term.setCursorPos(1, pos[2])
        term.write(prompt .. " " .. content)

        event, p1 = os.pullEvent()
        if event == "char" then
            content = content .. p1
        elseif event == "key" then
            if p1 == 14 then
                content = content:sub(1, -2)
            elseif p1 == 28 then
                print()
                return content
            end
        end
    end
end
