{ pkgs, config, inputs, system, ... }: {
  environment.systemPackages = (with pkgs; [
    inputs.ghostty.packages.x86_64-linux.default
    clamav
    zip
    sops
    speechd
    home-manager
    appimage-run
    busybox
    lsof
    unzip
    openssl
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
