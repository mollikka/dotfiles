local awful = require("awful")
local vain = require("vain")

local layouts = {}

--- dual layout draws first two clients side by side splitscreen and ignores the rest
layouts.duallayout = {}
layouts.duallayout.name = "duallayout"
layouts.duallayout.arrange = function(p)

  local work_x = p.workarea.x
  local work_y = p.workarea.y
  local work_width = p.workarea.width
  local work_height = p.workarea.height
  local clients = p.clients

  local left_pos = work_x
  local right_pos = work_x + work_width/2
  local hide_pos = work_x + work_width

  for i = 1,#clients do

    local c = clients[i]
    local g = {}
    local in_focus = (c == client.focus)

    g.width = work_width/2 - c.border_width*2
    g.height = work_height - c.border_width*2

    if (i == 1) then
      g.x = left_pos
    else if (i == 2) then
      g.x = right_pos
    else if (in_focus) then
      g.x = right_pos
    else
      g.x = hide_pos
    end end end
    g.y = work_y
    c:geometry(g)
  end
end

--- rc.lua sort of assumes that there are two layouts here

-- {{{ Layouts
layouts.layouts = {layouts.duallayout,
             awful.layout.suit.max}
-- }}}

return layouts

