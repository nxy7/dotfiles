{ pkgs, config, ... }: {
  environment.systemPackages = (with pkgs; [
    busybox
    lsof
    unzip
    openssl
    jq

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
    # nvtopPackages.nvidia

  ]);
}
