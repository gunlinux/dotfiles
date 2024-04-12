-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Solarized Dark - Patched'
config.audible_bell = "Disabled"
config.use_fancy_tab_bar = true

config.window_background_opacity = 0.9
config.hide_tab_bar_if_only_one_tab = true

local dimmer = {
  brightness = 0.03,
  hue = 1,
  saturation = 0.5,
}


if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- setup specific for windows
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

if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
  -- setup specific for linux
end

config.background = {
  {
    source = {
      File = wezterm.home_dir .. '/wall.jpg'
    },
    repeat_x = 'Mirror',
    hsb = dimmer,
    attachment = { Parallax = 0.1 },
  },
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
