package.path = package.path .. ';' .. os.getenv("HOME") .. '/.awesomeplugins/?.lua'
package.path = package.path .. ';' .. os.getenv("HOME") .. '/.awesomeplugins/*/?.lua'
package.path = package.path .. ';' .. os.getenv("HOME") .. '/.awesomeplugins/?/init.lua'

programlist = os.getenv("HOME") .. '/dotfiles/awesome/programmenu.lua'
widgetsfile = os.getenv("HOME") .. '/dotfiles/awesome/widgets.lua'
shortcutsfile = os.getenv("HOME") .. '/dotfiles/awesome/shortcuts.lua'

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

-- {{{ Variable definitions
terminal = "xfce4-terminal"
web = "chromium"
webmini = "chromium --app=http://reddit.com"
internet = "wicd-client"
mail = "thunderbird"
files = "thunar"
shutdown = "shutdown now"
restart = "shutdown now -r"
soundsettings = terminal .. " -x alsamixer"
lockscreen = "xscreensaver-command -lock"
volume_up = "amixer set Master 5%+"
volume_down = "amixer set Master 5%-"
screenshot = "screenshot.sh"

modkey = "Mod4" --Mod4 is the branded logo button
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
        gears.wallpaper.centered(beautiful.wallpaper, s)
    end
end
-- }}}


-- {{{ Layouts
  layouts = {awful.layout.suit.tile,
             awful.layout.suit.max}
-- }}}

-- {{{ Tags
  tags = {
    names = {"A","B","C"},
    layout = {layouts[1],layouts[1],layouts[1]}
  }
  for s = 1, screen.count() do
    tags[s] = awful.tag(tags.names, s, tags.layout)
  end
-- }}}


-- {{{ Menu

browsermenu = {
  { "normal", web },
  { "compact", webmini },
  { "mail", mail },
}

settingsmenu = {
  { "sound", soundsettings },
  { "wlan", internet },
}

awesomemenu = {
  { "restart", awesome.restart },
  { "quit", awesome.quit},
}

dofile(programlist)

mymainmenu = awful.menu({ items = {
    { "web", browsermenu },
    { "apps", myprograms },
    { "files", files },
    { "settings", settingsmenu },
    { "awesome", awesomemenu },
    { "restart", restart},
    { "shutdown", shutdown},
  }
})

mylauncher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = mymainmenu
})

menubar.utils.terminal = terminal -- terminal for applications that require it
-- }}}


-- {{{ Wibox

dofile(widgetsfile)

--- }}}

--- BUILD IT ALL

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mytasklist = {}
mytaglist = {}

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = theme.statbar_height })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    for w = 1, #widgets do
      right_layout:add(widgets[w])
    end

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

dofile(shortcutsfile)

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "Conky" },
      properties = {
        floating = true,
        sticky = true,
        ontop = false,
        focusable = false
    }},
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
