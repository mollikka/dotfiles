local awful = require("awful")
local naughty = require("naughty")

local defs = require("definitions")
local layouts = require("layouts")
local tags = require("tags")
local topbar = require("topbar")

local shortcuts = {}

local modkey = "Mod4" --Mod4 is the branded logo button

-- show key bindings
local function show_help()
  local file = io.open(defs.helpfile, "r")
  if file then
    local text = file:read "*a"
    naughty.notify({ preset = naughty.config.presets.normal,
                   title = "Shortcuts",
                   text = text,
                   position = "top_left",
                   timeout = 30,
                   })
  end
  file:close()
end

-- {{{ Key bindings
shortcuts.globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Tab",   function()
                                                      awful.client.focus.byidx(1) 
                                                      if client.focus then client.focus:raise() end
                                               end     ),
    awful.key({ modkey,           }, "Left",   function() awful.client.focus.byidx(-1) if client.focus then client.focus:raise() end end     ),
    awful.key({ modkey,           }, "h",      function() awful.client.focus.byidx(-1) if client.focus then client.focus:raise() end end     ),
    awful.key({ modkey,           }, "Right",  function() awful.client.focus.byidx(1)  if client.focus then client.focus:raise() end end     ),
    awful.key({ modkey,           }, "l",      function() awful.client.focus.byidx(1)  if client.focus then client.focus:raise() end end     ),
    awful.key({ modkey,  "Shift"  }, "Left",   function() awful.client.swap.byidx(-1)  if client.focus then client.focus:raise() end end     ),
    awful.key({ modkey,  "Shift"  }, "h",      function() awful.client.swap.byidx(-1)  if client.focus then client.focus:raise() end end     ),
    awful.key({ modkey,  "Shift"  }, "Right",  function() awful.client.swap.byidx(1)   if client.focus then client.focus:raise() end end     ),
    awful.key({ modkey,  "Shift"  }, "l",      function() awful.client.swap.byidx(1)   if client.focus then client.focus:raise() end end     ),
    awful.key({ modkey,           }, "Up",     awful.tag.viewprev),
    awful.key({ modkey,           }, "k",      awful.tag.viewprev),
    awful.key({ modkey, "Shift"   }, "Up",     tags.moveup),
    awful.key({ modkey, "Shift"   }, "k",      tags.moveup),
    awful.key({ modkey,           }, "Down",   awful.tag.viewnext),
    awful.key({ modkey,           }, "j",      awful.tag.viewnext),
    awful.key({ modkey, "Shift"   }, "Down",   tags.movedown),
    awful.key({ modkey, "Shift"   }, "j",      tags.movedown),

    -- Standard program
    awful.key({ modkey,           }, "t", function () awful.util.spawn(defs.terminal) end),

    -- Sound mixer
    awful.key({ modkey,           }, "s", function () awful.util.spawn(defs.soundsettings) end),

    -- WLAN settings
    awful.key({ modkey,           }, "w", function () awful.util.spawn(defs.internet) end),

    -- Browser
    awful.key({ modkey,           }, "b", function () awful.util.spawn(defs.web) end),

    -- E-mail
    awful.key({ modkey,           }, "m", function () awful.util.spawn(defs.email) end),

    -- Prompt
    awful.key({ modkey },            "r",     topbar.use_prompt),

    -- Show help
    awful.key({ modkey            }, "F1", show_help),


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
