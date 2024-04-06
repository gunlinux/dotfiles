-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Solarized Dark - Patched'
config.audible_bell = "Disabled"
config.use_fancy_tab_bar = true


-- config.window_background_image = "path"
config.window_background_opacity = 0.9
config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
