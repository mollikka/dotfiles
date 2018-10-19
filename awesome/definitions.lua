local definitions = {}
-- {{{ Variable definitions
local terminal = "urxvt"
local terminal_execute = function(cmd) return "urxvt -e " .. cmd end
definitions.terminal = terminal
definitions.terminal_execute = terminal_execute
definitions.web = "chromium"
definitions.email = "chromium --app='http://mail.google.com'"
definitions.internet = terminal_execute("wicd-curses")
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
definitions.cpu_popup = "ps -Ao user,comm,pid,pcpu,%mem --sort=-pcpu | head -n 11"
definitions.mem_popup = "ps -Ao user,comm,pid,pcpu,%mem --sort=-%mem | head -n 11"
---laptop mode enables things like battery display on top bar
definitions.laptopmode = true
return definitions
