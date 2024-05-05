-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Solarized Dark - Patched'
config.audible_bell = "Disabled"
config.use_fancy_tab_bar = false
config.tab_max_width = 64
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
    background = 'rgba(11,11,18,80%)',
    active_tab = {
      bg_color = 'rgba(0,30,39, 80%)',
      fg_color = '#708284',
    },

    inactive_tab = {
      bg_color = 'rgba(0,0,0,70%)',
      fg_color = 'rgba(112,130,132)',
    },

    inactive_tab_hover = {
      bg_color = 'rgba(0,30,39, 100%)',
      fg_color = '#708284',
    },

    new_tab = {
      bg_color = 'rgba(11,11,18,80%)',
      fg_color = 'rgba(112, 130, 132, 100%)',
    },

    new_tab_hover = {
      bg_color = 'rgba(0,30,39, 80%)',
      fg_color = '#c61c6f',
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

function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width) 
    local title = tab_title(tab)
    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    title = wezterm.truncate_right(title, max_width - 2)
    if tab.is_active then
      return {
        { Text = ' ' .. tab.title.. ' ' },
      }
    end
    return { { Text = ' ' .. tab.tab_index + 1 .. ' ' }} end
)

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
