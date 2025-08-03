local awful = require("awful")
local layouts = require("layouts")

local screens = {}

screens.moveup = function (c)
  client.focus:move_to_screen()
end
screens.movedown = function (c)
  client.focus:move_to_screen(client.focus.screen.index-1)
end

return screens
