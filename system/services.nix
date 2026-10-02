{ pkgs, ... }:
{
  systemd.services.nix-daemon.serviceConfig = {
    MemoryHigh = "16G";
    MemoryMax = "20G";
    CPUQuota = "400%";
  };

  # The display manager is GDM (visuals/gnome.nix). The old SDDM, autologin
  # and xrdp settings were dropped when this file was re-imported: SDDM would
  # clash with GDM, and none of them were active before.
  services = {
    xserver.enable = true;
    xserver.xkb.layout = "pl";
    xserver.videoDrivers = [
      "nvidia"
      "modesetting"
    ];

    flatpak.enable = true;
    resolved.enable = true;
    udev.packages = [ pkgs.via ];

    printing.enable = true;
  };
}
