local awful = require("awful")
local layouts = require("layouts")
local topbar = require("topbar")

local screens = {}

screens.moveup = function (c)
  client.focus:move_to_screen()
end
screens.movedown = function (c)
  client.focus:move_to_screen(client.focus.screen.index-1)
end
screens.focusup = function ()
  topbar.update_colors()
  awful.screen.focus_relative(1)
end
screens.focusdown = function ()
  topbar.update_colors()
  awful.screen.focus_relative(-1)
end

return screens
