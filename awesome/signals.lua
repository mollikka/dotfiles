local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local shortcuts = require("shortcuts")

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

  client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus c.opacity = 1 end)
  client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal c.opacity = 1 end)
  -- }}}
end

return signals
