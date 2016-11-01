local wibox = require("wibox")
local vicious = require("vicious")
local awful = require("awful")

datewidget = wibox.widget.textbox()
vicious.register(datewidget, vicious.widgets.date,"  %a %Y-%m-%d %H:%M:%S ", 1);

batterywidget = wibox.widget.textbox()
vicious.register(batterywidget, vicious.widgets.bat, "  BAT: $3",60, "BAT1")

volumewidget = wibox.widget.textbox()
vicious.register(volumewidget, vicious.widgets.volume, "  SND: $1 ", 3, "Master")

wifiwidget = wibox.widget.textbox()
vicious.register(wifiwidget, vicious.widgets.wifi, "  WLAN: ${ssid} ${linp}%",10 , "wlp2s0");

widgets = { --info widgets from right to left in the bar
    datewidget,
    batterywidget,
    volumewidget,
    wifiwidget,
}

