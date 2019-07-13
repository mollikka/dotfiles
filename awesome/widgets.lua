local wibox = require("wibox")
local vicious = require("vicious")
local awful = require("awful")
local defs = require("definitions")

local datewidget = wibox.widget.textbox()
vicious.register(datewidget, vicious.widgets.date,"  %a %Y-%m-%d %H:%M:%S ", 1);

local batterywidget = wibox.widget.textbox()
if defs.laptopmode then
  vicious.register(batterywidget, vicious.widgets.bat, " BAT: $2 ",3, "BAT0")
end

local volumewidget = wibox.widget.textbox()
-- vicious.register(volumewidget, vicious.widgets.volume, " SND: $1 ", 3, "Master")

local wifiwidget = wibox.widget.textbox()
if defs.laptopmode then
  vicious.register(wifiwidget, vicious.widgets.wifi, "  WLAN: ${ssid} ${linp}%",10 , "wlp2s0");
end

local widgets = { --info widgets from right to left in the bar
    datewidget,
    batterywidget,
    volumewidget,
    wifiwidget,
}
return widgets
