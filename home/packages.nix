{ inputs, pkgs, fullSystem, ... }: {
  home.packages = with pkgs;
    [ kustomize kube3d kubectl ] ++ lib.optionals (fullSystem) [
      ollama
      imagemagick
      # handbrake
      ventoy
      foot
      hyperfine
      multitime
      qmk
      just
      speechd
      guvcview
      warp-terminal
      figma-linux

      kooha
      flameshot
      satty

      k6
      deno
      wrk

      grpcurl
      grpcui
      bloomrpc
      diffutils

      unrar
      eza
      fd
      obsidian
      # inputs.zed-editor.packages."x86_64-linux".default
      aichat
      discord
      qbittorrent

      # game launchers
      lutris
      heroic
      # davinci-resolve
      chatgpt-cli

      vscode
      lnav

      mangohud

      gimp
      watchexec
      htop

      cachix
      keepassxc
      keepass-keeagent

      pgweb

      tokei
    ];
}

