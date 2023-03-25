{ inputs, outputs, lib, config, pkgs, username, helix-master, system, ... }: {
  home = rec {
    inherit username;
    homeDirectory = "/home/" + username;
    stateVersion = "23.05";

    packages = with pkgs; [
      nixfmt
      bun
      gitoxide
      sqlc
      htop
      sccache
      nodePackages_latest.ts-node
      gopls
      rust-analyzer
      python39
      qmk
      google-cloud-sdk-gce
      # rust support
      rustup
      # golang support
      go
      # javascript packages
      nodejs
      deno
      yarn
      nodePackages.pnpm

      # all stuff necesarry for helix lsp
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.prettier
      # other languages
      julia
      php

      # dev setup
      gcc
      # binutils-unwrapped_2_38
      lazygit
      tmux
      gh
    ];
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "nxyt";
      userEmail = "lolnoxy@gmail.com";
    };
    helix = {
      enable = true;
      package = helix-master.packages.${system}.default;
    };
    zsh = {
      enable = true;
      autocd = true;
      dotDir = ".config/zsh";
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      initExtraFirst = ''
        source $HOME/.config/aliases.sh
        source $HOME/.config/paths.sh
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "golang" "tmux" "rust" "gh" ];
        theme = "afowler";
      };
    };
    starship = { enable = true; };
    nushell = {
      enable = true;
      extraEnv = ''
        # source $HOME/.config/aliases.sh
      '';
    };
    zellij = { enable = true; };
  };

}

