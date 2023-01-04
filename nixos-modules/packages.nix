{ pkgs, config, inputs, system, ... }: {
  environment.systemPackages = (with pkgs; [
    ghostty
    zip
    sops
    speechd
    home-manager
    appimage-run
    busybox
    lsof
    unzip
    jq
    yq

    distrobox

    readarr
    stremio
    libreoffice-qt

    xclip
    wl-clipboard
    vlc

    usbutils
    git
    helix

    steam-run
    goxlr-utility
  ]);
}
