{ pkgs, ... }:
{

  home.packages = [ ];
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
  services.flameshot = {
    enable = true;
    settings.General = {
      showStartupLaunchMessage = false;
      saveLastRegion = true;
    };
  };

}
