-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
-- Edited by L.T.            --
-- There isn't really any Zenburn left
-------------------------------

-- Alternative icon sets and widget icons:
--  * http://awesome.naquadah.org/wiki/Nice_Icons

barheight = 20

normal_front = "#ffffff";--"#FEEACB"
normal_back  = "#181818";--"#282d3e"
highlight_front = "#000000";
highlight_back = "#dddddd";--"#FEEACB"--"#CC9393"

-- {{{ Main
theme = {}

theme.wallpaper = "~/dotfiles/awesome/theme/bg.jpg"

theme.wallpaper_bg_color = "#181b28"

-- }}}

-- {{{ Styles
theme.font      = "sans 9"

-- {{{ Colors
theme.fg_normal  = normal_front
theme.fg_focus   = highlight_front
theme.fg_urgent  = "#000000"
theme.bg_normal  = normal_back
theme.bg_focus   = highlight_back --"#1E2320"
theme.bg_urgent  = "#FF0000"
theme.bg_systray = normal_back
-- }}}

-- {{{ Borders
theme.border_width  = 3
theme.border_normal = normal_back
theme.border_focus  = highlight_back --"#6F6F6F"
theme.border_marked = "FF0000"

-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = barheight
theme.menu_width  = 140
theme.menu_bg_normal = normal_back
theme.menu_fg_normal = normal_front
theme.menu_bg_focus = highlight_back
theme.menu_fg_focus = highlight_front
theme.menu_border_width = 0
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = "~/dotfiles/awesome/theme/taglist/squarefz.png"
theme.taglist_squares_unsel = "~/dotfiles/awesome/theme/taglist/squarez.png"
-- theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = "~/dotfiles/awesome/theme/awesome-icon.png"
theme.menu_submenu_icon      = "~/dotfiles/awesome/theme/submenu.png"
theme.statbar_height = barheight
theme.notification_icon_size = 32
-- }}}

-- }}}

return theme
