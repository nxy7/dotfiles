{
  pkgs,
  config,
  ...
}:
{
  # powerManagement.powertop.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
  };

  services = {
    xrdp.enable = true;
    xrdp.defaultWindowManager = "gnome-remote-desktop";
    xrdp.openFirewall = true;
    xserver.wacom.enable = true;
    xserver.videoDrivers = [ "nvidia" ];
  };

  hardware = {
    opentabletdriver.enable = true;
    nvidia = {
      open = false;
      powerManagement = {
        enable = true;
        # finegrained = true;
      };
      nvidiaSettings = true;
      modesetting.enable = true;
    };
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        # intel-media-driver
        # vaapiIntel
        # vaapiVdpau
        # libvdpau-va-gl
      ];
    };
  };
}
