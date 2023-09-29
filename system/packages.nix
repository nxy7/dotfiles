{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    lsof
    unzip
    obsidian

    zip
    libreoffice-qt
    obs-studio

    xclip
    wl-clipboard
    vlc
    lutris

    vscode

    wget
    usbutils
    alacritty
    git
    helix

    ## browsers
    ungoogled-chromium
    brave
    firefox-devedition-bin
  ];
}
