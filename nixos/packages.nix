{ pkgs, stablepkgs, config, ... }: {
  environment.systemPackages = (with stablepkgs; [
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
  ]) ++ (with pkgs; [
    # wezterm
    kitty

    goxlr-utility

    mission-center
    nvtop-nvidia

    qt6.qtwayland
    config.boot.kernelPackages.v4l2loopback
  ]);
}
