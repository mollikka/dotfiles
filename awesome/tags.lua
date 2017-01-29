local awful = require("awful")
local layouts = require("layouts")

local tags = {}
for s = 1, screen.count() do
  tags[s] = awful.tag({"A","B","C"}, s, layouts.layouts[1])
end

tags.moveup = function (c)
  local curidx = awful.tag.getidx()
  local tags = client.focus.screen.tags
  if curidx == 1 then
    awful.client.movetotag(tags[#tags])
  else
    awful.client.movetotag(tags[curidx - 1])
  end
  awful.tag.viewprev()
  client.focus = c
end

tags.movedown = function (c)
  local curidx = awful.tag.getidx()
  local tags = client.focus.screen.tags
  if curidx == #tags then
    awful.client.movetotag(tags[1])
  else
    awful.client.movetotag(tags[curidx + 1])
  end
  awful.tag.viewnext()
  client.focus = c
end

return tags
