local naughty = require("naughty")

local notifications = {}

notifications.show_file = function(filename, title)
  local file = io.open(filename, "r")
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
  file:close()
end

notifications.show_cmd_output = function(command, title)
  local file = io.popen(command)
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
  file:close()
end

notifications.dismiss_notifications = function()
  local notifs = {}
  for s in pairs(naughty.notifications) do
    for p in pairs(naughty.notifications[s]) do
      for i, notification in pairs(naughty.notifications[s][p]) do
        notifs[#notifs + 1] = notification
      end
    end
  end
  for i,n in pairs(notifs) do
    n.die()
  end
end

return notifications
