
function utils.readFile(filename)
    file = fs.open(filename, "r")
    content = file.readAll()
    file.close()
    return content
end

return utils
