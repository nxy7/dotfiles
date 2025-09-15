{ lib, pkgs, ... }:
{
  security.polkit.enable = true;

  # Reduce systemd user manager timeout to prevent hanging on shutdown
  systemd.services."user@".serviceConfig.TimeoutStopSec = "30s";

  services = {

    # laptop batery
    thermald.enable = true;

    strongswan-swanctl.enable = true;

    # service exposed on port 14564
    goxlr-utility = {
      enable = true;
    };

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

    # ollama.enable = true;

    # clamav = {
    #   scanner.enable = false;
    #   daemon.enable = false;
    #   daemon.settings = { LogTime = true; };
    #   updater.enable = false;
    #   updater.interval = "daily";
    # };

    # samba
    # gvfs = {
    #   enable = true;
    #   package = lib.mkForce pkgs.gnome.gvfs;
    # };
    # speech-dispatcher.enable = true;
  };
}
