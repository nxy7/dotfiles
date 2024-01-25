{
  wayland.windowManager.hyprland = {
    enable = true;
    # settings = { };
    extraConfig = ''
      # See https://wiki.hyprland.org/Configuring/Monitors/
      # monitor=,preferred,auto,auto
      monitor = HDMI-A-1, preferred,auto, 1, transform, 3
      monitor = DP-2, 2560x1440@240, auto, 1



      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch
      exec-once = hyprpaper
      exec-once = ags
      exec-once = hyprctl setcursor Qogir 24
      exec-once = transmission-gtk


      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # Some default env vars.
      env = XCURSOR_SIZE,24

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
        kb_layout = pl
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =

        follow_mouse = 1

        touchpad {
            natural_scroll = no
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

        # dracula/hyprland
        general {
            col.active_border = rgba(bd93f944)
            col.inactive_border = rgba(44475aaa)
            col.nogroup_border = rgba(282a36dd)
            col.nogroup_border_active = rgb(bd93f9) rgb(44475a) 90deg
            no_border_on_floating = false
            border_size = 1

            # non-gradient alternative
            #col.active_border = rgb(bd93f9)
            #col.inactive_border = rgba(44475aaa)
            #col.group_border = rgba(282a36dd)
            #col.group_border_active = rgb(bd93f9)

            # darker alternative
            #col.active_border = rgb(44475a) # or rgb(6272a4)
            #col.inactive_border = rgb(282a36)
            #col.group_border = rgb(282a36)
            #col.group_border_active = rgb(44475a) # or rgb(6272a4)

        }
        decoration {
            col.shadow = rgba(1E202966)

            rounding = 4
            inactive_opacity = 0.92

            # suggested shadow setting
            drop_shadow = yes
            shadow_range = 60
            shadow_offset = 1 2
            shadow_render_power = 3
            shadow_scale = 0.97


            blur {
              enabled = true
              popups = true
            }
        }

        group {
            groupbar {
                col.active = rgb(bd93f9) rgb(44475a) 90deg
                col.inactive = rgba(282a36dd)
            }
        }
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

      master {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true
      }

      gestures {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = off
      }

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      device:epic-mouse-v1 {
        sensitivity = -0.5
      }

      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, Q, exec, kitty
      bind=CTRL SHIFT, R,  exec, ags -q; ags
      bind = $mainMod, W, exec, wezterm
      bind=SUPER, R,       exec, ags -t applauncher
      # bind = $mainMod, R, exec, tofi-drun | xargs hyprctl dispatch exec --
      bind=SUPER, Tab,     exec, ags -t overview
      bind = $mainMod, C, killactive, 
      # bind = $mainMod, M, exit, 
      bind = $mainMod, E, exec, nautilus
      bind = $mainMod, V, togglefloating, 
      bind = $mainMod, R, exec, wofi --show drun
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
    '';
  };
  home.file."hypr/hyprpaper.conf".text = ''
    someconf
  '';

}
