local definitions = {}
-- {{{ Variable definitions
local terminal = "urxvt"
local terminal_execute = function(cmd) return "urxvt -e " .. cmd end
definitions.terminal = terminal
definitions.terminal_execute = terminal_execute
definitions.web = "chromium"
definitions.email = "thunderbird"
definitions.internet = terminal_execute("sudo wifi-menu")
definitions.shutdown = "shutdown now"
definitions.restart = "shutdown now -r"
definitions.soundsettings = terminal_execute("alsamixer")
definitions.lockscreen = "xscreensaver-command -lock"
definitions.volume_up = "amixer set Master 5%+"
definitions.volume_down = "amixer set Master 5%-"
definitions.screenshot = "screenshot.sh"
definitions.backlight = "backlight.sh"
definitions.helpfile = os.getenv("HOME") .. '/dotfiles/SHORTCUTS.md'
definitions.calendar_popup = "cal -w3m"
---laptop mode enables things like battery display on top bar
definitions.laptopmode = true
return definitions
