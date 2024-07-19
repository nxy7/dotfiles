{ pkgs, inputs, config, ... }:
let
  extraConfig = # lua
    ''
      local wezterm = require "wezterm"
      local act = wezterm.action

      local config = wezterm.config_builder()

      config.hide_tab_bar_if_only_one_tab = true
      config.window_background_opacity = 0.85
      config.text_background_opacity = 0.85
      config.window_close_confirmation = "NeverPrompt"
      config.window_decorations = "NONE"
      config.keys = {
        {
          key = "F",
          mods = "SHIFT|CTRL|ALT",
          action = wezterm.action.Search { CaseInSensitiveString = "" },
        },
        { key = 'UpArrow',   mods = 'SHIFT',      action = act.ScrollToPrompt(-1) },
        { key = 'DownArrow', mods = 'SHIFT',      action = act.ScrollToPrompt(1) },

        { key = "P",         mods = "CTRL|SHIFT", action = wezterm.action.ActivateCommandPalette },
        {
          key = "N",
          mods = "CTRL|SHIFT",
          action = wezterm.action_callback(function(_, pane)
            local tab = pane:tab()
            local panes = tab:panes_with_info()
            if #panes == 1 then
              pane:split({
                direction = "Bottom",
                size = 0.4,
              })
            elseif not panes[1].is_zoomed then
              panes[1].pane:activate()
              tab:set_zoomed(true)
            elseif panes[1].is_zoomed then
              tab:set_zoomed(false)
              panes[2].pane:activate()
            end
          end),
        },
        {
          key = "H",
          mods = "CTRL|SHIFT",
          action = wezterm.action_callback(function(_, pane)
            local tab = pane:tab()
            local panes = tab:panes_with_info()
            if #panes == 1 then
              pane:split({
                direction = "Right",
                size = 0.4,
              })
            elseif not panes[1].is_zoomed then
              panes[1].pane:activate()
              tab:set_zoomed(true)
            elseif panes[1].is_zoomed then
              tab:set_zoomed(false)
              panes[2].pane:activate()
            end
          end),
        },
        { key = "K",     mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane { confirm = true }, },
        { key = 'R',     mods = 'CTRL|SHIFT', action = wezterm.action.RotatePanes 'Clockwise' },
        { key = 'Enter', mods = 'CTRL|SHIFT', action = wezterm.action.TogglePaneZoomState }
      }

      for i = 1, 11 do
        table.insert(config.keys, {
          key = 'F' .. tostring(i),
          action = wezterm.action.ActivateTab(i - 1),
        })
      end


      config.window_frame = {
        font = wezterm.font { family = "Roboto", weight = "Bold" },
        font_size = 15.0,
      }
      config.font_size = 18.0

      return config
    '';
in {
  programs.wezterm = {
    inherit extraConfig;
    enable = true;
  };
}
