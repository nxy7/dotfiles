{ pkgs, config, ... }:
{
  hardware = {
    keyboard.qmk.enable = true;

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        # nvidia-vaapi-driver
        libva-vdpau-driver
        libvdpau-va-gl
        # NVIDIA EGL/Wayland support
        egl-wayland
      ];
    };

    opentabletdriver.enable = true;
    nvidia = {
      open = false;
      # package = config.boot.kernelPackages.nvidiaPackages.beta;

      powerManagement = {
        enable = false;
        # finegrained = true;
      };
      nvidiaSettings = true;
      modesetting.enable = true;
    };

  };
}
