{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  environment.systemPackages = with pkgs;
    with gnomeExtensions; [
      paperwm
      blur-my-shell
      xdg-desktop-portal
      xdg-desktop-portal-gnome
    ];
}
