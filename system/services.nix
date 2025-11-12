{ pkgs, ... }:
{
  systemd.services.nix-daemon.serviceConfig = {
    MemoryHigh = "16G";
    MemoryMax = "20G";
    CPUQuota = "400%";
  };
  services = {
    xserver.xkb.layout = "pl,pl";

    flatpak.enable = true;
    resolved.enable = true;
    udev.packages = [ pkgs.via ];

    printing.enable = true;
  };
  services.xserver.enable = true;
  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;
    sddm.theme = "where_is_my_sddm_theme";

    autoLogin = {
      enable = true;
      user = "nxyt";
    };
  };
  services = {
    xrdp.enable = true;
    xrdp.openFirewall = true;
    xserver.videoDrivers = [
      "nvidia"
      "modesetting"
    ];
  };

}
