local json = require("json")

local comments = {}

function fetchComments()
	local rawJson = http.get("http://akatsuki-api.rf.gd/get_comments.php").readAll()
	comments = json.decode(rawJson)
end



local mon = peripheral.wrap("right")

mon.clear()
mon.setCursorPos(2, 2)
mon.write("Please wait...")
mon.setCursorPos(2, 3)
mon.write("Performing a network transaction")
mon.setCursorPos(2, 4)
mon.write("with Akatsuki's servers...")

fetchComments()

mon.clear()

for index, value in ipairs(comments) do
  mon.setCursorPos(2, index * 3 + 3)
  mon.write(value.user)
  mon.setCursorPos(3, index * 3 + 4)
  mon.write(value.comment)
end

