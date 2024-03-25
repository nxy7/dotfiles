{ pkgs, config, ... }: {
  environment.systemPackages = (with pkgs; [
    gnome.gnome-control-center
    busybox
    lsof
    unzip

    stremio
    zip
    libreoffice-qt

    xclip
    wl-clipboard
    vlc

    usbutils
    git
    helix

    wineWowPackages.stable
    # wezterm
    kitty

    goxlr-utility

    mission-center
    # nvtop-nvidia
    nvtopPackages.nvidia

    qt6.qtwayland
    config.boot.kernelPackages.v4l2loopback
  ]);
}
