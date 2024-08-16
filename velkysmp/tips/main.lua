require("utils")

mon = peripheral.wrap("back")

mon.setCursorPos(1, 1)
mon.setTextScale(0.5)

w, h = mon.getSize()

tips = 2
tip = 1

function printTitle(title)
    mon.setCursorPos(w / 2 - #title / 2 + 1, 1)
    mon.write(title)
    mon.setCursorPos(1, 2)
    for i = 1, w do
        mon.write("-")
    end
end

function renderTip()
    mon.clear()
    if tip == 1 then
        printTitle("How to change billboard color")
        mon.setCursorPos(1, 3)
        prettyWrite(mon,
            "To change the color of the billboard, you can use the VelkySMP site (https://velkysmp-mon.vercel.app) and customize your profile. To get a profile customization key, you can ping Akatsuki2555 on Discord. DO NOT DM THEM, THEY DO NOT ACCEPT ANY DM'S! If you change your profile settings, all of the changes will be reflected both on the site and the billboard.")
    elseif tip == 2 then
        printTitle("Viewing the full list")
        mon.setCursorPos(1, 3)
        prettyWrite(mon,
            "To view the full list, beyond what's displayed on the board, you can visit the website (https://velkysmp-mon.vercel.app) where the full list is displayed. You can even group players by playtime, online status and alphabetically.")
    end

    if tip > 1 then
        mon.setCursorPos(1, h)
        mon.write("<< PREVIOUS")
    end

    if tip < tips then
        mon.setCursorPos(w - 7, h)
        mon.write("NEXT >>")
    end
end

renderTip()

while true do
    os.queueEvent("tick")
    event, p1, p2, p3, p4, p5 = os.pullEvent()

    if event == "monitor_touch" then
        if p2 > 1 and p2 < 12 and p3 == h then
            print("previous")
            tip = tip - 1
            renderTip()
        end

        if p2 > w - 8 and p3 == h then
            print("next")
            tip = tip + 1
            renderTip()
        end
    end
end
