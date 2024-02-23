{ pkgs, config, ... }: {
  environment.systemPackages = (with pkgs; [
    lsof
    unzip
    strongswan

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
    nvtop-nvidia

    qt6.qtwayland
    config.boot.kernelPackages.v4l2loopback
  ]);
}
