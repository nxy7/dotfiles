{ inputs, pkgs, lib, config, system, ... }:
let
  hyprlandConfig = ''
    input {
      kb_layout = pl

      follow_mouse = 1

      touchpad {
        natural_scroll = no
      }

    }

      general {
        no_border_on_floating = false
        border_size = 0
      }
      decoration {
          col.shadow_inactive = rgba(1E2029ee)
          inactive_opacity = 0.92

          col.shadow = rgba(111111ee)
          drop_shadow = yes
          shadow_range = 27
          shadow_offset = 10 10
          shadow_render_power = 4
          shadow_scale = 0.97


          blur {
            enabled = true
            # popups = true
            new_optimizations = on
            size = 8
            passes = 3
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


    $mainMod = SUPER

    bind = $mainMod, K, exec, kitty
    bind = $mainMod, W, exec, wezterm

    bind=$mainMod SHIFT, R,  exec, asztal -q; asztal
    bind=SUPER,F,fullscreen

    # screenshots
    bind=,Print,exec,asztal -r 'recorder.screenshot()'
    bind=SHIFT,Print,exec,asztal -r 'recorder.screenshot(true)'
    bind=CTRL SHIFT,Print,exec,asztal -r 'recorder.start()'

    # bind=CTRL,Print,exec,grimblast copysave area - | swappy -f -

    # bind=,XF86Launch4,   exec, asztal -r 'recorder.start()'
    # bind=,Print,         exec, asztal -r 'recorder.screenshot()'
    # bind=SHIFT,Print,    exec, asztal -r 'recorder.screenshot(true)'

    bind=SUPER, R,       exec, asztal -t launcher
    bind=SUPER, Tab,     exec, asztal -t overview
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
    workspace=1,monitor:DP-1
    workspace=2,monitor:DP-1
    workspace=3,monitor:DP-1
    workspace=4,monitor:DP-1
    workspace=5,monitor:DP-1
    workspace=6,HDMI-A-1
    workspace=7,HDMI-A-1
    workspace=8,HDMI-A-1
    workspace=9,HDMI-A-1


    windowrule = workspace 1, title:(Firefox)
    windowrule = workspace 2, title:(Visual Studio Code)
    windowrule = workspace 5, title:(DataGrip)
    windowrule = workspace 4, title:(steam)
    windowrule = workspace 4 silent, title:(Bevy)
    windowrule = workspace 6, title:^(OBS)
    windowrule = workspace 7, title:(KeePassXC)
    windowrule = workspace 8, title:(Discord)
    windowrule = workspace 8, title:(Slack)

    monitor=desc:BNQ BenQ EX270QM 59N0147001Q,2560x1440@240,auto,1
    monitor=desc:DO NOT USE - RTK ZZX-FHD-HDR demoset-1,preferred,0x0,1,transform,3
    # monitor=DP-4,2560x1440@240,auto,1
    # monitor=HDMI-A-2,preferred,0x0,1,transform,3
    monitor=,preferred,auto,1  

    # Execute your favorite apps at launch
    exec-once = asztal
    exec-once = hyprctl setcursor Qogir 24
    exec-once = sleep 1 && xrandr --output DP-2 --primary
    exec-once = ${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1

    exec-once = keepassxc
    exec-once = discord
    exec-once = slack
    exec-once = nm-applet
  '';
in {
  imports = [

    # ./asztal 
    ./theme.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = hyprlandConfig;
  };

  # services.hyprpaper.enable = true;
  # services.hypridle.enable = true;
  # services.hyprlock.enable = true;

  home.packages = with pkgs; [
    # ags packaged as 'asztal' with Aylur config
    inputs.aylurDots.packages.x86_64-linux.default

    hyprpicker
    grimblast
    grim
    slurp
    swappy
    ksnip

    which
    dart-sass
    fd
    fzf
    brightnessctl
    swww
    matugen
    slurp
    wf-recorder
    wl-clipboard
    wayshot
    swappy
    hyprpicker
    pavucontrol
    networkmanager
    gtk3
    glib
    libsoup_3
    papirus-icon-theme
    gnome.adwaita-icon-theme

    libadwaita
  ];
}
