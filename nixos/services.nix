{ lib, pkgs, ... }:
{
  security.polkit.enable = true;

  services = {
    thermald.enable = true;
    strongswan-swanctl.enable = true;
    goxlr-utility.enable = true;
    syncthing = {
      enable = true;
      user = "nxyt";
      dataDir = "/home/nxyt/Sync";
      configDir = "/home/nxyt/.config/syncthing";
      guiAddress = "127.0.0.1:8384";
    };
    earlyoom = {
      enable = true;
      enableNotifications = true;
      freeMemThreshold = 5;
    };
    speechd.enable = true;
  };
}
