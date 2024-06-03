

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

