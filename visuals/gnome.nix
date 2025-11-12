{ pkgs, ... }:
{
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  environment.systemPackages =
    with pkgs;
    with gnomeExtensions;
    [
      # paperwm
      xdg-desktop-portal
      xdg-desktop-portal-gnome
    ];
}
