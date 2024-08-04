{ pkgs, config, inputs, system, ... }: {
  environment.systemPackages = (with pkgs; [
    inputs.agenix.packages.${pkgs.system}.default
    home-manager
    busybox
    lsof
    unzip
    openssl
    jq
    yq

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
