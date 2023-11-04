{ pkgs, unstablepkgs, ... }: {
  environment.systemPackages = (with pkgs; [
    lsof
    unzip
    obsidian

    stremio
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
    kitty
    git
    helix

    ## browsers
    ungoogled-chromium
    brave
    firefox-devedition-bin
  ]) ++ (with unstablepkgs; [ goxlr-utility ]);
}
