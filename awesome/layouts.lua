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


  -- Draw the first two clients. The rest will be outside visible screen.
  -- I regret nothing
  for i = 1,#clients
  do
    local c = clients[i]
    local g = {}

    g.width = work_width/2
    g.height = work_height

    left_pos = work_x
    right_pos = work_x + work_width/2
    hide_pos = work_x + work_width

    one_in_focus = clients[1] == client.focus
    two_in_focus = clients[2] == client.focus
    n_in_focus = not(one_in_focus) and not(two_in_focus)

    if (c == client.focus) then
      if (i == 1) then
        g.x = left_pos
      else
        g.x = right_pos
      end
    else
      if (one_in_focus and i==2) then
        g.x = right_pos
      end
      if (one_in_focus and i>2) then
        g.x = hide_pos
      end
      if (two_in_focus and i==1) then
        g.x = left_pos
      end
      if (two_in_focus and i>2) then
        g.x = hide_pos
      end
      if (n_in_focus and i==1) then
        g.x = left_pos
      end
      if (n_in_focus and i==2) then
        g.x = hide_pos
      end
      if (n_in_focus and i>2) then
        g.x = hide_pos
      end
    end

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

