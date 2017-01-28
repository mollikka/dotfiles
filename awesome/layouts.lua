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
    local client = clients[i]
    local g = {}

    g.width = work_width/2
    g.height = work_height

    g.x = work_x + work_width/2 * (i - 1)
    g.y = work_y

    client:geometry(g)

  end
end

--- rc.lua sort of assumes that there are two layouts here

-- {{{ Layouts
layouts.layouts = {layouts.duallayout,
             awful.layout.suit.max}
-- }}}

return layouts

