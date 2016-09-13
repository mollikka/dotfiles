local wibox = require("wibox")
local vicious = require("vicious")
local awful = require("awful")

datewidget = wibox.widget.textbox()
vicious.register(datewidget, vicious.widgets.date,"  %a %Y-%m-%d %H:%M  ", 20);

fileswidget = wibox.widget.textbox()
vicious.register(fileswidget, vicious.widgets.fs, "  FS: ${/ avail_gb}GB  ", 20);
fileswidget:buttons(awful.button({ }, 1, function() awful.util.spawn(files) end))

cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, vicious.widgets.cpu,"  CPU: $1% ", 20);

memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem,"RAM: $1% SWP: $5%  ", 20);

batterywidget = wibox.widget.textbox()
vicious.register(batterywidget, vicious.widgets.bat, "  BAT: $3  ",60, "BAT1")

volumewidget = wibox.widget.textbox()
vicious.register(volumewidget, vicious.widgets.volume, "  SND: $1  ", 10, "Master")
volumewidget:buttons(awful.button({ }, 1, function() awful.util.spawn(soundsettings) end))

wifiwidget = wibox.widget.textbox()
vicious.register(wifiwidget, vicious.widgets.wifi, "  WLAN: ${ssid} ${linp}%  ",10 , "wlp2s0");
wifiwidget:buttons(awful.button({ }, 1, function() awful.util.spawn(internet) end))

updatewidget = wibox.widget.textbox()
vicious.register(updatewidget, vicious.widgets.pkg,
  function(widget, args)
    if args[1] == 0 then
      return ""
    else
      return "  " .. args[1] .. " updates"
    end
  end
    , 600, "Arch")

widgets = { --info widgets from right to left in the bar
    datewidget,
    fileswidget,
    cpuwidget,
    memwidget,
    batterywidget,
    volumewidget,
    wifiwidget,
    updatewidget,
}

