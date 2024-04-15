-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Solarized Dark - Patched'
config.audible_bell = "Disabled"
config.use_fancy_tab_bar = true


config.window_background_opacity = 1
config.hide_tab_bar_if_only_one_tab = true

local dimmer = {
  -- Darken the background image by reducing it to 1/3rd
  brightness = 0.05,

  -- You can adjust the hue by scaling its value.
  -- a multiplier of 1.0 leaves the value unchanged.
  hue = 1,

  -- You can adjust the saturation also.
  saturation = 1,
}


if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  local wsl_domains = wezterm.default_wsl_domains()

  for _, dom in ipairs(wsl_domains) do
    if dom.name == 'WSL:Ubuntu' then
      dom.default_prog = { '/bin/bash' }
    end
  end

  config.wsl_domains = wsl_domains
  config.default_domain = 'WSL:Ubuntu'
  config.window_padding = {
    left = '1cell',
    right = '1cell',
    top = '2cell',
    bottom = '1cell',
  }
end

if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then -- x86_64-unknown-linux-gnu
  config.window_background_opacity = 1
end

config.background = {
  {
    source = {
      File = wezterm.home_dir .. '/wall.jpg'
    },
    repeat_x = 'Mirror',
    hsb = dimmer,
    opacity = 0.3,
    height = 'Cover',
  },
}

config.window_background_gradient = {
  colors = { '#002b36', '#002b36', '#000' },
  -- Specifices a Linear gradient starting in the top left corner.
  orientation = { Linear = { angle = -45.0 } },
}

config.keys = {
  -- Turn off the default CMD-m Hide action, allowing CMD-m to
  -- be potentially recognized and handled by the tab
  {
    key = 'F12',
    mods = '',
    action = wezterm.action.ToggleFullScreen,
  },
}


-- and finally, return the configuration to wezterm
return config
