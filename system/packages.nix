{ pkgs, config, inputs, system, ... }: {
  environment.systemPackages = (with pkgs; [
    inputs.agenix.packages.${pkgs.system}.default
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
