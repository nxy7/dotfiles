{ pkgs, inputs, config, ... }: {
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;
    extraConfig = ''
      local wezterm = require "wezterm"

      local config = wezterm.config_builder()

      config.enable_wayland = false
      config.front_end = "WebGpu"
      config.window_decorations = "NONE"
      config.hide_tab_bar_if_only_one_tab = true
      config.window_background_opacity = 0.75
      config.text_background_opacity = 0.75
      config.window_close_confirmation = "NeverPrompt"
      config.keys = {
        -- search for things that look like git hashes
        {
          key = "F",
          mods = "SHIFT|CTRL|ALT",
          action = wezterm.action.Search { CaseInSensitiveString = "" },
        },
        {
          key = "w",
          mods = "CMD",
          action = wezterm.action.CloseCurrentPane { confirm = true },
        },
      }



      config.window_frame = {
        font = wezterm.font { family = "Roboto", weight = "Bold" },
        font_size = 15.0,
        -- active_titlebar_bg = "none",
        -- inactive_titlebar_bg = "none",
        -- button_bg = "none",
        -- inactive_titlebar_border_bottom = "none",
        -- active_titlebar_border_bottom = "none",
      }
      config.font_size = 18.0

      config.use_fancy_tab_bar = false
      config.colors = {
        tab_bar = {
          background = "#${config.lib.stylix.colors.base00}",
          active_tab = {
            fg_color = "#FFFFFF",
            bg_color = "#${config.lib.stylix.colors.base00}",
          },
          inactive_tab = {
            fg_color = "#AAAAAA",
            bg_color = "#${config.lib.stylix.colors.base00}",
          },
          new_tab = {
            fg_color = "#1c1917",
            bg_color = "#${config.lib.stylix.colors.base00}",
          },
        },
      }


      config.freetype_load_target = "Light"

      return config
            
    '';
  };
}
