-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Solarized Dark - Patched'
config.audible_bell = "Disabled"
config.use_fancy_tab_bar = false 
config.exit_behavior = 'Close'


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
    config.background = default_background
    config.window_background_gradient = default_gradient
  end
  config.default_prog = { "/usr/bin/bash" }

end

-- Adopts the current default fancy styling with more padding, more distinct tab outline, glyphs/buttons
config.colors = {
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = 'rgba(11,11,18,80%)',
    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      --bg_color = 'rgba(0,43,54, 100%)',
      bg_color = '#001822',
      -- The color of the text for the tab
      fg_color = '#c0c0c0',

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = 'Normal',

      underline = 'None',
      italic = false,
      strikethrough = false,
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = 'rgba(0,0,0,70%)',
      fg_color = '#808080',
      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#909090',
      italic = false,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab_hover`.
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = '#4f006f',
      fg_color = 'rgba(0,0,0,50%)',
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#909090',
      italic = true,
      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab_hover`.
    },
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

wezterm.font_with_fallback({
  {family="Operator Mono SSm Lig", weight="DemiLight"},
  "Material Design Icons Desktop",
  "JetBrains Mono",
  "Noto Color Emoji",
})

config.font_size = 16.0
--config.allow_squary_glypth_tro_overflow_width = "WhenFollowedBySpace"
config.enable_wayland = false
 -- and finally, return the configuration to wezterm
return config
