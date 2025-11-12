{ pkgs, inputs, ... }:
{
  programs.niri.enable = true;
  environment = {
    variables.NIXOS_OZONE_WL = "1";
    sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

    # cosmic.excludePackages = with pkgs; [
    #   cosmic-player
    #   cosmic-store
    #   cosmic-term
    # ];
    systemPackages = with pkgs; [
      # cosmic-ext-applet-clipboard-manager
      # cosmic-ext-applet-emoji-selector
      # examine
      forecast
      wl-clipboard
      grim
      slurp
    ];
  };

  services = {
    desktopManager.cosmic = {
      enable = true;
      xwayland.enable = false;
    };

    displayManager.cosmic-greeter.enable = true;
  };

  services.displayManager.sessionPackages = [
    (
      (pkgs.writeTextFile {
        name = "cosmic-on-niri";
        destination = "/share/wayland-sessions/COSMIC-on-niri.desktop";
        text = ''
          [Desktop Entry]
          Name=COSMIC-on-niri
          Comment=This session logs you into the COSMIC desktop on niri
          Type=Application
          DesktopNames=niri
          Exec=${
            pkgs.writeShellApplication {
              name = "start-cosmic-ext-niri";
              runtimeInputs = [
                pkgs.systemd
                pkgs.dbus
                pkgs.cosmic-session
                pkgs.bash
                pkgs.coreutils
                pkgs.niri
              ];
              text = ''
                set -e

                # From: https://people.debian.org/~mpitt/systemd.conf-2016-graphical-session.pdf

                if command -v systemctl >/dev/null; then
                    # robustness: if the previous graphical session left some failed units,
                    # reset them so that they don't break this startup
                    for unit in $(systemctl --user --no-legend --state=failed --plain list-units | cut -f1 -d' '); do
                        partof="$(systemctl --user show -p PartOf --value "$unit")"
                        for target in cosmic-session.target graphical-session.target; do
                            if [ "$partof" = "$target" ]; then
                                systemctl --user reset-failed "$unit"
                                break
                            fi
                        done
                    done
                fi

                # use the user's preferred shell to acquire environment variables
                # see: https://github.com/pop-os/cosmic-session/issues/23
                if [ -n "''${SHELL:-}" ]; then
                    # --in-login-shell: our flag to indicate that we don't need to recurse any further
                    if [ "''${1:-}" != "--in-login-shell" ]; then
                        # `exec -l`: like `login`, prefixes $SHELL with a hyphen to start a login shell
                        exec bash -c "exec -l ${"'"}''${SHELL}' -c ${"'"}''${0} --in-login-shell'"
                    fi
                fi

                export XDG_CURRENT_DESKTOP="''${XDG_CURRENT_DESKTOP:=COSMIC:niri}"
                export XDG_SESSION_TYPE="''${XDG_SESSION_TYPE:=wayland}"
                export XCURSOR_THEME="''${XCURSOR_THEME:=Cosmic}"
                export _JAVA_AWT_WM_NONREPARENTING=1
                export GDK_BACKEND=wayland,x11
                export MOZ_ENABLE_WAYLAND=1
                export QT_QPA_PLATFORM="wayland;xcb"
                export QT_AUTO_SCREEN_SCALE_FACTOR=1
                export QT_ENABLE_HIGHDPI_SCALING=1

                if command -v systemctl >/dev/null; then
                    # set environment variables for new units started by user service manager
                    systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP
                fi
                # Run cosmic-session
                if [[ -z "''${DBUS_SESSION_BUS_ADDRESS}" ]]; then
                    exec dbus-run-session -- ${pkgs.cosmic-session}/bin/cosmic-session ${pkgs.niri}/bin/niri --session
                else
                    exec ${pkgs.cosmic-session}/bin/cosmic-session ${pkgs.niri}/bin/niri --session
                fi
              '';
            }
          }/bin/start-cosmic-ext-niri
        '';
      }).overrideAttrs
      (old: {
        passthru.providedSessions = [ "COSMIC-on-niri" ];
      })
    )
  ];
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    inputs.nixos-cosmic.packages.x86_64-linux.xdg-desktop-portal-cosmic
    # pkgs.xdg-desktop-portal-gnome
  ];
  xdg.portal.config = {
    niri = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.Access" = [ "gtk" ];
      "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
      "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
    };
  };
  xdg.portal.configPackages = [
    inputs.nixos-cosmic.packages.x86_64-linux.xdg-desktop-portal-cosmic
    # specialArgs.s-nixpkgs.niri-unstable
  ];

}
