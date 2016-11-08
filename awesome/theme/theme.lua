-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
-- Edited by L.T.            --
-- There isn't really any Zenburn left
-------------------------------

-- Alternative icon sets and widget icons:
--  * http://awesome.naquadah.org/wiki/Nice_Icons

-- {{{ Main
theme = {}
theme.wallpaper = "~/dotfiles/awesome/theme/wp.svg"
-- }}}

-- {{{ Styles
theme.font      = "sans 10"

-- {{{ Colors
theme.fg_normal  = "#D0D0D0"
theme.fg_focus   = "#000000"
theme.fg_urgent  = "#CC9393"
theme.bg_normal  = "#202020"
theme.bg_focus   = "#44AA08" --"#1E2320"
theme.bg_urgent  = "#3F3F3F"
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.border_width  = 2
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_focus --"#6F6F6F"
theme.border_marked = "#CC9393"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = 30
theme.menu_width  = 140
theme.menu_border_color = theme.border_marked
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
-- }}}

-- }}}

return theme
