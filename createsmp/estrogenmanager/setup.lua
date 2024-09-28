function pickPeripheral()
    local devices = peripheral.getNames()
    term.clear()
    term.setCursorPos(1, 1)
    print("Choose a device:")
    for i, device in ipairs(devices) do
        print(i .. ": " .. device)
    end
    local function getNumber(prompt)
        local input = read()
        local number = tonumber(input)
        while number == nil do
            print(prompt)
            input = read()
            number = tonumber(input)
        end
        return number
    end
    local choice = getNumber("Enter the number of the device: ")
    while choice < 1 or choice > #devices do
        print("Invalid choice. Please try again.")
        choice = getNumber("Enter the number of the device: ")
    end
    return devices[choice]
end

print("Please pick a device:")
local chosenDevice = pickPeripheral()
print("Chosen device: " .. chosenDevice)
