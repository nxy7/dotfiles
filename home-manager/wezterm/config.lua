local wezterm = require 'wezterm'

local config = wezterm.config_builder()


-- For example, changing the color scheme:
-- config.tab_bar_style = ""
config.enable_wayland = true
-- config.text_background_opacity = 0.0
config.front_end = "WebGpu"
config.color_scheme = 'zenbones_dark'
config.window_decorations = "NONE"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.75
config.text_background_opacity = 0.75
config.window_close_confirmation = 'NeverPrompt'
config.keys = {
  -- search for things that look like git hashes
  {
    key = 'F',
    mods = 'SHIFT|CTRL|ALT',
    action = wezterm.action.Search { CaseInSensitiveString = '' },
  },
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
{ key = 'UpArrow',   mods = 'ALT', action = wezterm.action.ScrollToPrompt(-1) },
{ key = 'DownArrow', mods = 'ALT', action = wezterm.action.ScrollToPrompt(1) },

}



config.window_frame = {
  font = wezterm.font { family = 'Roboto', weight = 'Bold' },
  font_size = 15.0,
  -- active_titlebar_bg = 'none',
  -- inactive_titlebar_bg = 'none',
  -- button_bg = 'none',
  -- inactive_titlebar_border_bottom = 'none',
  -- active_titlebar_border_bottom = 'none',
}

config.use_fancy_tab_bar = false
config.colors = {
  tab_bar = {
    -- inactive_tab_edge = 'none',
    background = '#1c1917',
    active_tab = {
      fg_color = '#FFFFFF',
      bg_color = '#1c1917',
    },
    inactive_tab = {
      fg_color = '#AAAAAA',
      bg_color = '#1c1917',
    },
    new_tab = {
      fg_color = '#1c1917',
      bg_color = '#1c1917',
    },
  },
}


config.freetype_load_target = "Light"

return config
