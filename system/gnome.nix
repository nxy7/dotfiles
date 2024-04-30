{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
  };
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "nxyt";
    };
  };

  services.xserver = {
    layout = "pl";
    xkbVariant = "";
  };

}
