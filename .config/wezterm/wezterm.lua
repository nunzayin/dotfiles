local wez = require "wezterm"

local conf = {}

conf.color_scheme = "Wryan"
conf.enable_tab_bar = false
conf.window_padding = {
    left = 1,
    right = 1,
    top = 1,
    bottom = 1,
}
conf.keys = {
    {
        key = 'Enter',
        mods = 'ALT',
        action = wez.action.DisableDefaultAssignment,
    },
}

return conf
