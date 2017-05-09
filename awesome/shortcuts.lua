local awful = require("awful")
local naughty = require("naughty")

local defs = require("definitions")
local layouts = require("layouts")
local tags = require("tags")
local topbar = require("topbar")

local shortcuts = {}

local modkey = "Mod4" --Mod4 is the branded logo button


local function show_file(file, title)
  if file then
    local text = file:read "*a"
    naughty.notify({ preset = naughty.config.presets.normal,
                   title = title,
                   text = text,
                   position = "top_left",
                   timeout = 30,
                   font = "DejaVu Sans Mono 12",
                   })
  end
end

-- show key bindings
local function show_help()
  local file = io.open(defs.helpfile, "r")
  show_file(file, "Shortcuts")
  file:close()
end

-- show calendar popup
local function show_calendar()
  local file = io.popen(defs.calendar_popup)
  show_file(file, "Calendar")
  file:close()
end

local function select_nth_client(n)
  local clients = awful.client.visible(awful.screen.focused())

  if #clients >= n then
    awful.client.jumpto(clients[n]);
  end
end

local function swap_nth_client(n)
  local clients = awful.client.visible(awful.screen.focused())
  local focusid
  for i=1,#clients do
    if clients[i] == client.focus then
      focusid = i
      break
    end
  end

  if #clients >= n then
    awful.client.swap.byidx(n-focusid);
  end
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


    awful.key({ modkey,           }, "1", function () select_nth_client(1) end),
    awful.key({ modkey,           }, "2", function () select_nth_client(2) end),
    awful.key({ modkey,           }, "3", function () select_nth_client(3) end),
    awful.key({ modkey,           }, "4", function () select_nth_client(4) end),
    awful.key({ modkey,           }, "5", function () select_nth_client(5) end),
    awful.key({ modkey,           }, "6", function () select_nth_client(6) end),
    awful.key({ modkey,           }, "7", function () select_nth_client(7) end),
    awful.key({ modkey,           }, "8", function () select_nth_client(8) end),
    awful.key({ modkey,           }, "9", function () select_nth_client(9) end),
    awful.key({ modkey,           }, "0", function () select_nth_client(10) end),

    awful.key({ modkey, "Shift"   }, "1", function () swap_nth_client(1) end),
    awful.key({ modkey, "Shift"   }, "2", function () swap_nth_client(2) end),
    awful.key({ modkey, "Shift"   }, "3", function () swap_nth_client(3) end),
    awful.key({ modkey, "Shift"   }, "4", function () swap_nth_client(4) end),
    awful.key({ modkey, "Shift"   }, "5", function () swap_nth_client(5) end),
    awful.key({ modkey, "Shift"   }, "6", function () swap_nth_client(6) end),
    awful.key({ modkey, "Shift"   }, "7", function () swap_nth_client(7) end),
    awful.key({ modkey, "Shift"   }, "8", function () swap_nth_client(8) end),
    awful.key({ modkey, "Shift"   }, "9", function () swap_nth_client(9) end),
    awful.key({ modkey, "Shift"   }, "0", function () swap_nth_client(10) end),

    -- Standard program
    awful.key({ modkey,           }, "t", function () awful.util.spawn(defs.terminal) end),

    -- Browser
    awful.key({ modkey,           }, "b", function () awful.util.spawn(defs.web) end),

    -- E-mail
    awful.key({ modkey,           }, "m", function () awful.util.spawn(defs.email) end),

    -- Prompt
    awful.key({ modkey },            "r",     topbar.use_prompt),

    -- Show help
    awful.key({ modkey            }, "F1", show_help),

    -- Calendar popup
    awful.key({ modkey,           }, "c", show_calendar),

    -- WLAN settings
    awful.key({ modkey,           }, "F3", function () awful.util.spawn(defs.internet) end),
    awful.key({ modkey,           }, "w", function () awful.util.spawn(defs.internet) end),

    -- Restart Awesome
    awful.key({ modkey            }, "F5", function () awesome.restart() end),

    -- Screen brightness
    awful.key({ modkey            }, "F6", function () awful.util.spawn(defs.backlight) end),

    -- Mouse out of the way
    awful.key({ modkey            }, "F7", function () mouse.coords({ x=0, y=0 }) end),

    -- Sound mixer
    awful.key({ modkey,           }, "F8", function () awful.util.spawn(defs.soundsettings) end),
    awful.key({ modkey,           }, "s", function () awful.util.spawn(defs.soundsettings) end),

    -- Lock screen
    awful.key({ modkey,           }, "F12", function () awful.util.spawn(defs.lockscreen) end),

    -- Screenshot
    awful.key({                   }, "Print", function () awful.util.spawn(defs.screenshot) end),

    -- Shutdown Awesome
    awful.key({ modkey, "Ctrl"    }, "Delete",    function (c) awesome.quit() end),

    -- Restart Awesome
    awful.key({ modkey,"Ctrl","Shift"}, "Delete", function () awesome.restart() end),

    -- Shutdown system
    awful.key({ modkey,           }, "Delete",    function (c) awful.util.spawn(defs.shutdown) end),

    -- Reboot system
    awful.key({ modkey, "Shift"   }, "Delete",    function (c) awful.util.spawn(defs.restart) end)
)

shortcuts.clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "F11",    function (c) awful.layout.inc(layouts.layouts,  1) end),
    awful.key({ modkey,           }, "F4",     function (c) c:kill()     end)
)
return shortcuts
