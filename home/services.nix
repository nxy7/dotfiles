{ pkgs, ... }: {

  home.packages = [ ];
  services.swaync = { enable = true; };
  services.flameshot = {
    enable = true;
    settings.General = {
      showStartupLaunchMessage = false;
      saveLastRegion = true;
    };
  };

}
