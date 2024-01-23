-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.tab_bar_style = ""
config.color_scheme = 'zenbones_dark'
config.window_decorations = "NONE"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.96
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
  
}

-- config.skip_close_confirmation_for_processes_named = {
--   'bash',
--   'sh',
--   'zsh',
--   'fish',
--   'tmux',
--   'nu',
--   'cmd.exe',
--   'pwsh.exe',
--   'powershell.exe',
--   'hx',
--   'docker',
-- }


config.window_frame = {
  font = wezterm.font { family = 'Roboto', weight = 'Bold' },
  font_size = 12.0,
  active_titlebar_bg = '#333333',
  inactive_titlebar_bg = '#333333',
}

config.colors = {
  tab_bar = {
    inactive_tab_edge = '#575757',
  },
}


config.freetype_load_target = "Light"

-- and finally, return the configuration to wezterm
return config
