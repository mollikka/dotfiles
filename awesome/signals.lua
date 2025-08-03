local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local shortcuts = require("shortcuts")
local topbar = require("topbar")

local notifications = require("notifications")

local idletime = 5;
local idlecounter = 0;
local last_recorded_mouse_coords = {x=0, y=0};
local idle_mouse_coords = {x=0, y=0};
local idle_mode = false;

local mouse_wakeup = function()
  -- mouse is moving
  idlecounter = 0;
  if idle_mode then
    -- wake up
    mouse.coords(idle_mouse_coords);
    idle_mode = false;
  end
end

local mouse_idle_poller = gears.timer {
    timeout = 0.1,
    autostart = true,
    single_shot = true,
    callback = function()
        local new_position = mouse.coords();
        if (new_position.x == last_recorded_mouse_coords.x) and
           (new_position.y == last_recorded_mouse_coords.y) then
           -- mouse didn't move
            if (idlecounter >= idletime) and not idle_mode then
              -- go idle
              idle_mouse_coords = mouse.coords();
              idle_mode = true;
              mouse.coords({x = mouse.screen.geometry.width-1,
                            y = mouse.screen.geometry.height-1});
              last_recorded_mouse_coords = {x = mouse.screen.geometry.width-1,
                                            y = mouse.screen.geometry.height-1};
            else
              last_recorded_mouse_coords = new_position;
            end
            idlecounter = idlecounter+1;
        else
            mouse_wakeup();
            last_recorded_mouse_coords = new_position;
        end
        mouse_idle_poller:again();
      end
}
idletime = 5/mouse_idle_poller.timeout;

-- {{{ Mouse bindings
clientbuttons = gears.table.join(
    awful.button({ }, 1, function()
      mouse_wakeup();
    end),
    awful.button({ }, 2, function()
      mouse_wakeup();
    end),
    awful.button({ }, 3, function()
      mouse_wakeup();
    end),
    awful.button({ }, 4, function()
      mouse_wakeup();
    end),
    awful.button({ }, 5, function()
      mouse_wakeup();
    end)
);

local signals = {}
signals.create = function()
  -- {{{ Rules
  -- Rules to apply to new clients (through the "manage" signal).
  awful.rules.rules = {
      -- All clients will match this rule.
      { rule = { },
        properties = { border_width = beautiful.border_width,
                       border_color = beautiful.border_normal,
                       focus = awful.client.focus.filter,
                       raise = true,
                       screen = awful.screen.focused,
                       keys = shortcuts.clientkeys,
                       size_hints_honor = false,
                       maximized_horizontal = false,
                       maximized_vertical = false,
                       maximized = false,
                       buttons = clientbuttons } },
  }
  -- }}}

  -- {{{ Signals
  -- Signal function to execute when a new client appears.
  client.connect_signal("manage", function (c, startup)


  end)

  client.connect_signal("focus", function(c) 
    c.border_color = beautiful.border_focus c.opacity = 1
  end)
  client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal c.opacity = 1 end)
  -- }}}
end

return signals
