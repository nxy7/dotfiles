{ pkgs, lib, isLinux ? pkgs.stdenv.isLinux, ... }:
{
  home.packages = [ ];

  # Linux-only services
  systemd.user.targets.tray = lib.mkIf isLinux {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };

  services.flameshot = lib.mkIf isLinux {
    enable = true;
    settings.General = {
      showStartupLaunchMessage = false;
      saveLastRegion = true;
    };
  };

}
