-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Nightfly (Gogh)'
config.audible_bell = "Disabled"
config.use_fancy_tab_bar = true
config.tab_max_width = 64
config.exit_behavior = 'Close'
config.front_end = "WebGpu"


config.window_background_opacity = 1
config.hide_tab_bar_if_only_one_tab = true

local dimmer = {
  brightness = 0.05,
  hue = 1,
  saturation = 1,
}

local default_background = {
  {
     source = {
       File = wezterm.home_dir .. '/wall.jpg'
     },
     repeat_x = 'Mirror',
     hsb = dimmer,
     opacity = 0.4,
     height = 'Cover',
  },
}

local default_gradient = {
  colors = { '#073642', '#002b36', '#073642', '#002b36',},
  -- Specifices a Linear gradient starting in the top left corner.
  orientation = { Linear = { angle = 0} },
}


if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  local wsl_domains = wezterm.default_wsl_domains()

  for _, dom in ipairs(wsl_domains) do
    if dom.name == 'WSL:Ubuntu' then
      dom.default_prog = { '/bin/bash' }
    end
  end
  config.background = default_background
  config.window_background_gradient = default_gradient
  config.wsl_domains = wsl_domains
  config.default_domain = 'WSL:Ubuntu'
  config.window_padding = {
    left = '1cell',
    right = '1cell',
    top = '2cell',
    bottom = '1cell',
  }
end

if wezterm.target_triple == 'x86_64-apple-darwin' then
  config.background = default_background
  config.window_background_gradient = default_gradient
end

if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then -- x86_64-unknown-linux-gnu
  config.window_background_opacity = 1
  if os.getenv 'XDG_SESSION_TYPE' == 'wayland' then
    config.window_background_opacity = 0.8
  else
    config.enable_wayland = false
    config.background = default_background
    config.window_background_gradient = default_gradient
  end
  config.default_prog = { "/usr/bin/bash" }

end

-- Adopts the current default fancy styling with more padding, more distinct tab outline, glyphs/buttons
config.colors = {
  tab_bar = {
    inactive_tab_edge = 'rgba(0,0,0,0%)',
    background = 'rgba(255,11,18,90%)',

    active_tab = {
      bg_color = '#021A2A',
      fg_color = "#c3ccdc",
    },

    inactive_tab = {
      bg_color = 'rgb(1,22,39, 100%)',
      fg_color = 'rgba(112,130,132)',
    },

    inactive_tab_hover = {
      bg_color = 'rgba(0,30,39,100%)',
      fg_color = '#708284',
    },

    new_tab = {
      bg_color = 'rgba(11,11,18,0%)',
      fg_color = 'rgba(198,28, 111, 100%)',
    },

    new_tab_hover = {
      bg_color = 'rgba(0,30,39, 0%)',
      fg_color = 'rgba(198,28, 111, 100%)',
    },
  },
}

config.window_frame = {
  font_size = 15.0,

  -- The overall background color of the tab bar when
  -- the window is focused
  active_titlebar_bg = 'rgba(198,28,111, 0%)',
  -- The overall background color of the tab bar when
  -- the window is not focused
  inactive_titlebar_bg = 'rgba(0,0,0,0%)',
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

wezterm.font_with_fallback({
  {family="Operator Mono SSm Lig", weight="DemiLight"},
  "Material Design Icons Desktop",
  "JetBrains Mono",
  "Noto Color Emoji",
})

config.font_size = 18.0
 -- and finally, return the configuration to wezterm
return config
