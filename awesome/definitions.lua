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
backlight = "backlight.sh"
---laptop mode enables things like battery display on top bar
laptopmode = true
