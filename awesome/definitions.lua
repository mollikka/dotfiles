local definitions = {}
-- {{{ Variable definitions
local terminal = "xfce4-terminal"
definitions.terminal = terminal
definitions.web = "chromium"
definitions.webmini = "chromium --app=http://reddit.com"
definitions.internet = terminal .. " -x wicd-curses"
definitions.mail = "thunderbird"
definitions.files = "thunar"
definitions.shutdown = "shutdown now"
definitions.restart = "shutdown now -r"
definitions.soundsettings = terminal .. " -x alsamixer"
definitions.lockscreen = "xscreensaver-command -lock"
definitions.volume_up = "amixer set Master 5%+"
definitions.volume_down = "amixer set Master 5%-"
definitions.screenshot = "screenshot.sh"
definitions.backlight = "backlight.sh"
---laptop mode enables things like battery display on top bar
definitions.laptopmode = true
return definitions
