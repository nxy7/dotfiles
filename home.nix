{ inputs, outputs, lib, config, pkgs, username, helix-master, system, ... }: {
  home = rec {
    inherit username;
    homeDirectory = "/home/" + username;
    stateVersion = "23.05";

    packages = with pkgs; [
      nixfmt
      cargo-espflash
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

  # imports = [ ./helix.nix ];

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "nxyt";
      userEmail = "lolnoxy@gmail.com";
    };
    helix = import ./helix/helix.nix;
    # zsh = import ./zsh.nix;
    starship = { enable = true; };
    # nushell = import ./nushell.nix;
    zellij = { enable = true; };
  };

}

