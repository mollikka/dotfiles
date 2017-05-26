local awful = require("awful")
local vain = require("vain")

local layouts = {}

local get_focus_id = function(clients)
  local focus_id = 0
  for i = 1,#clients do
    local c = clients[i]
    local in_focus = (c == client.focus)
    if in_focus then
      focus_id = i
      break
    end
  end
  return focus_id
end

-- browsingtriple
layouts.browsingtriple = {}
layouts.browsingtriple.name = "browsing triple"
layouts.browsingtriple.arrange = function(p)

  local work_x = p.workarea.x
  local work_y = p.workarea.y
  local work_width = p.workarea.width
  local work_height = p.workarea.height
  local clients = p.clients

  local left_pos = work_x
  local mid_pos = work_x + work_width/3
  local right_pos = work_x + work_width/3*2
  local hide_pos = work_x + work_width

  local focus_id = get_focus_id(clients)

  if (#clients < 3) then
    layouts.duallayout.arrange(p)
    return
  end

  for i=1,#clients do

    local c = clients[i]
    local g = {}
    g.width = work_width/3 - c.border_width*2
    g.height = work_height - c.border_width*2

    if ((i-focus_id)%#clients == #clients-1) then
      g.x = left_pos
    else if ((i-focus_id)%#clients == 0) then
      g.x = mid_pos
    else if ((i-focus_id)%#clients == 1) then
      g.x = right_pos
    else
      g.x = hide_pos
    end end end
    g.y = work_y
    c:geometry(g)
  end
end
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

  local focus_id = get_focus_id(clients)

  for i = 1,#clients do

    local c = clients[i]
    local g = {}
    local in_focus = (i == focus_id)

    g.width = work_width/2 - c.border_width*2
    g.height = work_height - c.border_width*2

    if (i == 1) then
      g.x = left_pos
    else if (i == 2) and (focus_id < 3) then
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

-- {{{ Layouts
layouts.layouts = {layouts.duallayout,
              layouts.browsingtriple,
             awful.layout.suit.max}
-- }}}

return layouts

