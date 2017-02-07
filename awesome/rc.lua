package.path = package.path .. ';' .. os.getenv("HOME") .. '/.awesomeplugins/?.lua'
package.path = package.path .. ';' .. os.getenv("HOME") .. '/.awesomeplugins/*/?.lua'
package.path = package.path .. ';' .. os.getenv("HOME") .. '/.awesomeplugins/?/init.lua'

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
-- Addons
local vicious = require("vicious")
-- My own config files
local layouts = require("layouts")
local widgets = require("widgets")
local shortcuts = require("shortcuts")
local defs = require("definitions")
local tags = require("tags")
local topbar = require("topbar")
local signals = require("signals")
--- }}}

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Theme
beautiful.init(awful.util.getdir("config") .. "/" .. "theme/theme.lua")
--- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.fit(beautiful.wallpaper, s, beautiful.wallpaper_bg_color)
    end
end
-- }}}

--- {{{ Set default terminal
menubar.utils.terminal = defs.terminal
-- }}}

-- Set keys
root.keys(shortcuts.globalkeys)
-- }}}

