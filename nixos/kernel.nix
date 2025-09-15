{
  pkgs,
  config,
  ...
}:
{
  # powerManagement.powertop.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=0" ];
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
      open = true;
      # package = config.boot.kernelPackages.nvidiaPackages.beta;

      # powerManagement = {
      # enable = true;
      # finegrained = true;
      # };
      # nvidiaSettings = true;
      modesetting.enable = false;
    };
    graphics = {
      enable = true;
      # extraPackages = with pkgs; [
      # intel-media-driver
      # vaapiIntel
      # vaapiVdpau
      # libvdpau-va-gl
      # ];
    };
  };
}
