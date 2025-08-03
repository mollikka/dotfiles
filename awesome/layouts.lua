local awful = require("awful")

local definitions = require("definitions")

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
  local hide_pos = work_x + work_width/3*2

  local focus_id = get_focus_id(clients)

  for i=1,#clients do

    local c = clients[i]
    local g = {}
    g.width = work_width/3 - c.border_width*2
    g.height = work_height - c.border_width*2

    if (i == 1) then
      g.x = left_pos
    else if (i == 2) then
      g.x = mid_pos
    else
      g.x = right_pos
    end end

    g.y = work_y
    c:geometry(g)
  end
  clients[3]:raise()
  clients[2]:raise()
  clients[1]:raise()
  clients[focus_id]:raise()
end
--- dual layout draws first two clients side by side splitscreen and ignores the rest
layouts.duallayout = {}
layouts.duallayout.name = "duallayout"
layouts.duallayout.getnmaster = function() return 2 end
layouts.duallayout.getncol = function() return 2 end
layouts.duallayout.arrange = function(p)

  local work_x = p.workarea.x
  local work_y = p.workarea.y
  local work_width = p.workarea.width
  local work_height = p.workarea.height
  local clients = p.clients

  local left_pos = work_x
  local right_pos = work_x + work_width/2
  local hide_pos = -100000 --work_x + work_width/2

  local focus_id = get_focus_id(clients)

  for i = 1,#clients do

    local c = clients[i]
    local g = {}
    local in_focus = (i == focus_id)

    g.width = work_width/2 - c.border_width*2
    g.height = work_height - c.border_width*2

    if (i == 1) then
      g.x = left_pos
    else
      g.x = right_pos
    end
    g.y = work_y

    c:geometry(g)
  end

  clients[2]:raise()
  clients[1]:raise()
  clients[focus_id]:raise()
end

layouts.create = function()
  awful.layout.layouts = {
    layouts.duallayout,
    layouts.browsingtriple,
    awful.layout.suit.fair,
    awful.layout.suit.max}

end

layouts.default = layouts.duallayout

return layouts

