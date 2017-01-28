local awful = require("awful")
local defs = require("definitions")
local layouts = require("layouts")

local shortcuts = {}

local modkey = "Mod4" --Mod4 is the branded logo button
-- {{{ Key bindings
shortcuts.globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Tab",   function()
                                                      awful.client.focus.byidx(1) 
                                                      if client.focus then client.focus:raise() end
                                               end     ),
    awful.key({ modkey,           }, "Left",   function() awful.client.focus.byidx(-1) if client.focus then client.focus:raise() end end     ),
    awful.key({ modkey,           }, "h",      function() awful.client.focus.byidx(-1) if client.focus then client.focus:raise() end end     ),
    awful.key({ modkey,           }, "Right",  function()awful.client.focus.byidx(1)  if client.focus then client.focus:raise() end end     ),
    awful.key({ modkey,           }, "l",      function()awful.client.focus.byidx(1)  if client.focus then client.focus:raise() end end     ),
    awful.key({ modkey,  "Shift"  }, "Left",   function() awful.client.swap.byidx(-1)  if client.focus then client.focus:raise() end end     ),
    awful.key({ modkey,  "Shift"  }, "h",      function() awful.client.swap.byidx(-1)  if client.focus then client.focus:raise() end end     ),
    awful.key({ modkey,  "Shift"  }, "Right",  function()awful.client.swap.byidx(1)   if client.focus then client.focus:raise() end end     ),
    awful.key({ modkey,  "Shift"  }, "l",      function()awful.client.swap.byidx(1)   if client.focus then client.focus:raise() end end     ),
    awful.key({ modkey,           }, "Up",     awful.tag.viewprev),
    awful.key({ modkey,           }, "k",      awful.tag.viewprev),
    awful.key({ modkey, "Shift"   }, "Up",
        function (c)
          local curidx = awful.tag.getidx()
          local c = client.focus
          if curidx == 1 then
            awful.client.movetotag(tags[client.focus.screen][#tags[client.focus.screen]])
          else
            awful.client.movetotag(tags[client.focus.screen][curidx - 1])
          end
          awful.tag.viewprev()
          client.focus = c
        end),
    awful.key({ modkey, "Shift"   }, "k",
        function (c)
          local curidx = awful.tag.getidx()
          local c = client.focus
          if curidx == 1 then
            awful.client.movetotag(tags[client.focus.screen][#tags[client.focus.screen]])
          else
            awful.client.movetotag(tags[client.focus.screen][curidx - 1])
          end
          awful.tag.viewprev()
          client.focus = c
        end),

    awful.key({ modkey,           }, "Down",   awful.tag.viewnext),
    awful.key({ modkey,           }, "j",      awful.tag.viewnext),

    awful.key({ modkey, "Shift"   }, "Down",
        function (c)
          local curidx = awful.tag.getidx()
          local c = client.focus
          if curidx == #tags[client.focus.screen] then
            awful.client.movetotag(tags[client.focus.screen][1])
          else
            awful.client.movetotag(tags[client.focus.screen][curidx + 1])
          end
          awful.tag.viewnext()
          client.focus = c
        end),
    awful.key({ modkey, "Shift"   }, "j",
        function (c)
          local curidx = awful.tag.getidx()
          local c = client.focus
          if curidx == #tags[client.focus.screen] then
            awful.client.movetotag(tags[client.focus.screen][1])
          else
            awful.client.movetotag(tags[client.focus.screen][curidx + 1])
          end
          awful.tag.viewnext()
          client.focus = c
        end),

    -- Standard program
    awful.key({ modkey,           }, "t", function () awful.util.spawn(defs.terminal) end),

    -- Sound mixer
    awful.key({ modkey,           }, "s", function () awful.util.spawn(defs.soundsettings) end),

    -- WLAN settings
    awful.key({ modkey,           }, "w", function () awful.util.spawn(defs.internet) end),

    -- Browser
    awful.key({ modkey,           }, "b", function () awful.util.spawn(defs.web) end),

    -- File browser
    awful.key({ modkey,           }, "f", function () awful.util.spawn(defs.files) end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    -- Restart Awesome
    awful.key({ modkey            }, "F5", function () awesome.restart() end),

    -- Mouse out of the way
    awful.key({ modkey            }, "F7", function () mouse.coords({ x=0, y=0 }) end),

    -- Lock screen
    awful.key({ modkey,           }, "F12", function () awful.util.spawn(defs.lockscreen) end),

    -- Screenshot
    awful.key({                   }, "Print", function () awful.util.spawn(defs.screenshot) end)
)

shortcuts.clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "F11",    function (c) awful.layout.inc(layouts.layouts,  1) end),
    awful.key({ modkey,           }, "F4",     function (c) c:kill()     end),
    awful.key({ modkey,           }, "Delete",    function (c) awesome.quit() end)
)
return shortcuts
