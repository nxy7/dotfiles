{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager = {
      autoLogin = {
        enable = true;
        user = "nxyt";
      };
    };
    desktopManager.gnome.enable = true;
  };

  services.xserver = {
    layout = "pl";
    xkbVariant = "";
  };

}
