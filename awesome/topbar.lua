local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
beautiful.init(awful.util.getdir("config") .. "/" .. "theme/theme.lua")

local widgets = require("widgets")

topbar = {}

-- Create a wibox for each screen and add it
local mywibox = {}
local mypromptbox = awful.widget.prompt()
local mytasklist = {}
local mytaglist = {}

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = theme.statbar_height })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox)

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    for w = 1, #widgets do
      right_layout:add(widgets[w])
    end

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

topbar.use_prompt = function()
  mypromptbox:run()
end

return topbar
