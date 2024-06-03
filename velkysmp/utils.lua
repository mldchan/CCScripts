
function readFile(filename)
    file = fs.open(filename, "r")
    content = file.readAll()
    file.close()
    return content
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