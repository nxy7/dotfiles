{ pkgs, fullSystem, ... }: {
  home.packages = with pkgs;
    [ kustomize kube3d kubectl ] ++ lib.optionals (fullSystem) [
      speechd
      eza
      fd
      obsidian
      zed-editor
      aichat
      discord
      qbittorrent-qt5

      # browsers
      vivaldi
      # ungoogled-chromium
      # firefox
      firefox-devedition
      brave

      # game launchers
      lutris
      heroic

      chatgpt-cli

      vscode
      lnav

      mangohud

      gimp
      htop

      cachix
      keepassxc

      pgweb

      tokei
    ];
}

