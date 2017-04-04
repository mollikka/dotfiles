local definitions = {}
-- {{{ Variable definitions
local terminal = "urxvt"
local terminal_execute = "urxvt -e "
definitions.terminal = terminal
definitions.web = "chromium"
definitions.webmini = "chromium --app=http://reddit.com"
definitions.email = "thunderbird"
definitions.internet = terminal_execute .. "wicd-curses"
definitions.mail = "thunderbird"
definitions.internet = terminal_execute .. "sudo wifi-menu"
definitions.shutdown = "shutdown now"
definitions.restart = "shutdown now -r"
definitions.soundsettings = terminal_execute .. "alsamixer"
definitions.lockscreen = "xscreensaver-command -lock"
definitions.volume_up = "amixer set Master 5%+"
definitions.volume_down = "amixer set Master 5%-"
definitions.screenshot = "screenshot.sh"
definitions.backlight = "backlight.sh"
definitions.helpfile = os.getenv("HOME") .. '/dotfiles/SHORTCUTS.md'
---laptop mode enables things like battery display on top bar
definitions.laptopmode = true
return definitions
