
local what = read("What? ")

if what == "aes" then
  shell.run("wget https://github.com/bighil/aeslua/raw/master/src/aeslua.lua")
  shell.run("mkdir aeslua")
  shell.run("wget https://github.com/bighil/aeslua/raw/master/src/aeslua/aes.lua aeslua/aes.lua")
  shell.run("wget https://github.com/bighil/aeslua/raw/master/src/aeslua/buffer.lua aeslua/buffer.lua")
  shell.run("wget https://github.com/bighil/aeslua/raw/master/src/aeslua/ciphermode.lua aeslua/ciphermode.lua")
  shell.run("wget https://github.com/bighil/aeslua/raw/master/src/aeslua/gf.lua aeslua/gf.lua")
  shell.run("wget https://github.com/bighil/aeslua/raw/master/src/aeslua/util.lua aeslua/util.lua")
end

