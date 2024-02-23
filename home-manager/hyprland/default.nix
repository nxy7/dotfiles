{ inputs, pkgs, ... }:
let
  hyprlandConfig = ''
    input {
      kb_layout = pl

      follow_mouse = 1

      touchpad {
        natural_scroll = no
      }

      # device:mice {
      #   sensitivity = 0
      # }
    }

      general {
        no_border_on_floating = false
        border_size = 0
      }
      decoration {
          col.shadow_inactive = rgba(1E202900)

          rounding = 5
          inactive_opacity = 0.92

          # suggested shadow setting
          col.shadow = rgb(111111)
          drop_shadow = yes
          shadow_range = 27
          # shadow_offset = 0 0
          shadow_render_power = 2
          # shadow_scale = 0.97


          blur {
            enabled = true
            popups = true
            new_optimizations = on
            size = 8
            passes = 3
          }
      }

      group {
          groupbar {
              col.active = rgb(bd93f9) rgb(44475a) 90deg
              col.inactive = rgba(282a36dd)
          }
      }
    # Some default env vars.
    env = XCURSOR_SIZE,24
    env = LIBVA_DRIVER_NAME,nvidia
    env = XDG_SESSION_TYPE,wayland
    env = GBM_BACKEND,nvidia-drm
    env = __GLX_VENDOR_LIBRARY_NAME,nvidia
    env = WLR_NO_HARDWARE_CURSORS,1

    windowrulev2 = bordercolor rgb(ff5555),xwayland:1 # check if window is xwayland

    animations {
      enabled = yes

      # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

      bezier = myBezier, 0.05, 0.9, 0.1, 1.05

      animation = windows, 1, 7, myBezier
      animation = windowsOut, 1, 7, default, popin 80%
      animation = border, 1, 10, default
      animation = borderangle, 1, 8, default
      animation = fade, 1, 7, default
      animation = workspaces, 1, 6, default
    }

    dwindle {
      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = yes # you probably want this
    }

    # master {
    #   # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    #   new_is_master = true
    # }

    # gestures {
    #   # See https://wiki.hyprland.org/Configuring/Variables/ for more
    #   workspace_swipe = off
    # }

    # Example per-device config
    # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more

    $mainMod = SUPER

    bind = $mainMod, K, exec, kitty
    bind = $mainMod, W, exec, wezterm

    bind=$mainMod SHIFT, R,  exec, ags -q; ags
    bind=SUPER,F,fullscreen
    bind=,Print,exec,grimblast copy area

    bind=SUPER, R,       exec, ags -t applauncher
    bind=SUPER, Tab,     exec, ags -t overview
    bind = $mainMod SHIFT, Q, killactive, 
    bind = $mainMod, E, exec, nautilus
    bind = $mainMod, V, togglefloating, 
    bind = $mainMod, P, pseudo, # dwindle
    bind = $mainMod, J, togglesplit, # dwindle

    # Move focus with mainMod + arrow keys
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d

    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # Scroll through existing workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow

    # Example windowrule v1
    workspace=1,monitor:DP-2
    workspace=2,monitor:DP-2
    workspace=3,monitor:DP-2
    workspace=4,monitor:DP-2
    workspace=5,monitor:DP-2
    workspace=6,monitor:HDMI-A-1
    workspace=7,monitor:HDMI-A-1
    workspace=8,monitor:HDMI-A-1
    workspace=9,monitor:HDMI-A-1


    windowrule = workspace 5, title:(steam)
    windowrule = workspace 6, title:^(OBS)
    windowrule = workspace 7, title:(KeePassXC)
    windowrule = workspace 8, title:(Discord)

    monitor=DP-2,2560x1440@240,auto,1
    monitor=HDMI-A-1,preferred,0x0,1,transform,3
    monitor=,preferred,auto,1  

    # Execute your favorite apps at launch
    exec-once = ags
    exec-once = hyprctl setcursor Qogir 24
    exec-once = xrandr --output DP-2 --primary
    exec-once = ${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1

    exec-once = keepassxc
    exec-once = discord
  '';
in {
  wayland.windowManager.hyprland = {
    enable = true;
    # settings = { };
    extraConfig = hyprlandConfig;
    # plugins = with pkgs; [ ];
  };

  home.packages = with pkgs; [ hyprpicker grimblast grim slurp ];
  programs.rofi = { enable = true; };
}
