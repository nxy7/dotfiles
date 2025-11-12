{ pkgs, ... }:
{
  home.pointerCursor =
    let
      getFrom = url: hash: name: {
        gtk.enable = true;
        x11.enable = true;
        name = name;
        size = 32;
        package = pkgs.runCommand "moveUp" { } ''
          mkdir -p $out/share/icons
          ln -s ${
            pkgs.fetchzip {
              url = url;
              hash = hash;
            }
          } $out/share/icons/${name}
        '';
      };
    in
    getFrom "https://github.com/ful1e5/fuchsia-cursor/releases/download/v2.0.0/Fuchsia-Pop.tar.gz"
      "sha256-BvVE9qupMjw7JRqFUj1J0a4ys6kc9fOLBPx2bGaapTk="
      "Fuchsia-Pop";

  # programs.dankMaterialShell = {
  #   enable = true;
  #   niri = {
  #     # enableKeybinds = true;
  #     enableSpawn = true;
  #   };
  # };

  programs.niri.settings = {
    environment = {
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      XCURSOR_THEME = "Fuchsia-Pop";
      XCURSOR_SIZE = "48";
      # # NVIDIA EGL/Wayland support
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      # __EGL_VENDOR_LIBRARY_FILENAMES = "/run/opengl-driver/share/glvnd/egl_vendor.d/10_nvidia.json";
    };
    # Startup applications
    spawn-at-startup = [
      { command = [ "niriswitcher" ]; }
      {
        command = [
          "wl-paste"
          "--watch"
          "cliphist"
          "store"
        ];
      }
    ];

    binds = {
      # Help overlay
      "Mod+Shift+Slash".action.show-hotkey-overlay = { };

      # Terminal and launcher
      "Mod+T".action.spawn = "ghostty";
      "Mod+D".action.spawn = [
        "dms"
        "ipc"
        "call"
        "spotlight"
        "toggle"
      ];

      # Niriswitcher - Alt+Tab window switching using gdbus
      "Alt+Tab" = {
        repeat = false;
        action.spawn = [
          "gdbus"
          "call"
          "--session"
          "--dest"
          "io.github.isaksamsten.Niriswitcher"
          "--object-path"
          "/io/github/isaksamsten/Niriswitcher"
          "--method"
          "io.github.isaksamsten.Niriswitcher.application"
        ];
      };
      "Alt+Shift+Tab" = {
        repeat = false;
        action.spawn = [
          "gdbus"
          "call"
          "--session"
          "--dest"
          "io.github.isaksamsten.Niriswitcher"
          "--object-path"
          "/io/github/isaksamsten/Niriswitcher"
          "--method"
          "io.github.isaksamsten.Niriswitcher.application"
        ];
      };
      "Alt+Grave" = {
        repeat = false;
        action.spawn = [
          "niriswitcherctl"
          "show"
          "--workspace"
        ];
      };
      "Alt+Shift+Grave" = {
        repeat = false;
        action.spawn = [
          "niriswitcherctl"
          "show"
          "--workspace"
        ];
      };

      # Overview
      "Mod+O".action.toggle-overview = { };

      # DankMaterialShell bindings
      "Mod+Alt+N" = {
        allow-when-locked = true;
        action.spawn = [
          "dms"
          "ipc"
          "night"
          "toggle"
        ];
      };
      "Mod+Comma".action.spawn = [
        "dms"
        "ipc"
        "settings"
        "toggle"
      ];
      "Mod+M".action.spawn = [
        "dms"
        "ipc"
        "processlist"
        "toggle"
      ];
      "Mod+N".action.spawn = [
        "dms"
        "ipc"
        "notifications"
        "toggle"
      ];
      "Mod+P".action.spawn = [
        "dms"
        "ipc"
        "notepad"
        "toggle"
      ];
      "Mod+Space".action.spawn = [
        "dms"
        "ipc"
        "spotlight"
        "toggle"
      ];
      "Mod+V".action.spawn = [
        "dms"
        "ipc"
        "clipboard"
        "toggle"
      ];
      "Mod+X".action.spawn = [
        "dms"
        "ipc"
        "powermenu"
        "toggle"
      ];
      "Super+Alt+L".action.spawn = [
        "dms"
        "ipc"
        "lock"
        "lock"
      ];

      # DankMaterialShell media keys
      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;
        action.spawn = [
          "dms"
          "ipc"
          "audio"
          "increment"
          "3"
        ];
      };
      "XF86AudioLowerVolume" = {
        allow-when-locked = true;
        action.spawn = [
          "dms"
          "ipc"
          "audio"
          "decrement"
          "3"
        ];
      };
      "XF86AudioMute" = {
        allow-when-locked = true;
        action.spawn = [
          "dms"
          "ipc"
          "audio"
          "mute"
        ];
      };
      "XF86AudioMicMute" = {
        allow-when-locked = true;
        action.spawn = [
          "dms"
          "ipc"
          "audio"
          "micmute"
        ];
      };
      "XF86MonBrightnessUp" = {
        allow-when-locked = true;
        action.spawn = [
          "dms"
          "ipc"
          "brightness"
          "increment"
          "5"
          ""
        ];
      };
      "XF86MonBrightnessDown" = {
        allow-when-locked = true;
        action.spawn = [
          "dms"
          "ipc"
          "brightness"
          "decrement"
          "5"
          ""
        ];
      };

      # Window management
      "Mod+Q".action.close-window = { };

      # Focus windows (vim keys)
      "Mod+H".action.focus-column-left = { };
      "Mod+J".action.focus-window-down = { };
      "Mod+K".action.focus-window-up = { };
      "Mod+L".action.focus-column-right = { };

      # Focus windows (arrow keys)
      "Mod+Left".action.focus-column-left = { };
      "Mod+Down".action.focus-window-down = { };
      "Mod+Up".action.focus-window-up = { };
      "Mod+Right".action.focus-column-right = { };

      # Move windows (vim keys)
      "Mod+Ctrl+H".action.move-column-left = { };
      "Mod+Ctrl+J".action.move-window-down = { };
      "Mod+Ctrl+K".action.move-window-up = { };
      "Mod+Ctrl+L".action.move-column-right = { };

      # Move windows (arrow keys)
      "Mod+Ctrl+Left".action.move-column-left = { };
      "Mod+Ctrl+Down".action.move-window-down = { };
      "Mod+Ctrl+Up".action.move-window-up = { };
      "Mod+Ctrl+Right".action.move-column-right = { };

      # Focus monitors
      "Mod+Shift+H".action.focus-monitor-left = { };
      "Mod+Shift+J".action.focus-monitor-down = { };
      "Mod+Shift+K".action.focus-monitor-up = { };
      "Mod+Shift+L".action.focus-monitor-right = { };

      # Workspace navigation
      "Mod+U".action.focus-workspace-down = { };
      "Mod+I".action.focus-workspace-up = { };
      "Mod+Page_Down".action.focus-workspace-down = { };
      "Mod+Page_Up".action.focus-workspace-up = { };

      # Move to workspace
      "Mod+Ctrl+U".action.move-column-to-workspace-down = { };
      "Mod+Ctrl+I".action.move-column-to-workspace-up = { };
      "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = { };
      "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = { };

      # Direct workspace access
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;

      # Move window to workspace
      "Mod+Ctrl+1".action.move-column-to-workspace = 1;
      "Mod+Ctrl+2".action.move-column-to-workspace = 2;
      "Mod+Ctrl+3".action.move-column-to-workspace = 3;
      "Mod+Ctrl+4".action.move-column-to-workspace = 4;
      "Mod+Ctrl+5".action.move-column-to-workspace = 5;
      "Mod+Ctrl+6".action.move-column-to-workspace = 6;
      "Mod+Ctrl+7".action.move-column-to-workspace = 7;
      "Mod+Ctrl+8".action.move-column-to-workspace = 8;
      "Mod+Ctrl+9".action.move-column-to-workspace = 9;

      # Window sizing
      "Mod+R".action.switch-preset-column-width = { };
      "Mod+Shift+R".action.switch-preset-window-height = { };
      "Mod+Ctrl+R".action.reset-window-height = { };
      "Mod+F".action.maximize-column = { };
      "Mod+Shift+F".action.fullscreen-window = { };
      "Mod+C".action.center-column = { };

      # Fine adjustments
      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";
      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      # Column operations
      "Mod+Period".action.expel-window-from-column = { };

      # Screenshots - copy to clipboard
      "Print".action.spawn = [
        "sh"
        "-c"
        "grim -g \"$(slurp)\" - | wl-copy"
      ];
      "Ctrl+Print".action.spawn = [
        "sh"
        "-c"
        "grim - | wl-copy"
      ];
      # Screenshot and save to file
      "Shift+Print".action.screenshot = { };

      # System
      "Mod+Shift+E".action.quit = { };
      "Mod+Shift+P".action.power-off-monitors = { };
    };
  };
}
