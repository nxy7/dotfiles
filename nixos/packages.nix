{ pkgs, unstablepkgs, config, ... }: {
  environment.systemPackages = (with pkgs; [
    lsof
    unzip
    kitty

    stremio
    zip
    libreoffice-qt

    xclip
    wl-clipboard
    vlc
    lutris
    heroic

    vscode

    usbutils
    git
    helix

    wineWowPackages.stable
  ]) ++ (with unstablepkgs; [
    goxlr-utility
    obs-studio
    config.boot.kernelPackages.v4l2loopback
  ]);
}
