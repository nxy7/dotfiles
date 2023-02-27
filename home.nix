{inputs, outputs, lib, config, pkgs, helix-master, ...}:
{
  home.homeDirectory = "/home/nxy7";
  home.username = "nxy7";
  home.stateVersion = "23.05";
  
  home.packages = [
    pkgs.gitoxide
    # pkgs.zsh-powerlevel10k
    pkgs.sqlc
    pkgs.htop
    pkgs.sccache
    pkgs.nodePackages_latest.ts-node
    pkgs.fswatch
    pkgs.haskellPackages.latex
    pkgs.zellij
    pkgs.podman-compose
    pkgs.nil
    pkgs.gopls
    pkgs.texlab
    pkgs.rust-analyzer
    pkgs.python39
    pkgs.qmk
    # zig and tree-sitter to fix neovim tree-sitter (you can find it in treesitter config) bug
    pkgs.zig
    pkgs.tree-sitter
    pkgs.llvm
    pkgs.gcc
    # rust support
    pkgs.rustup
    # golang support
    pkgs.go
    # javascript packages
    pkgs.nodejs
    pkgs.deno
    pkgs.yarn
    pkgs.nodePackages.pnpm

    # all stuff necesarry for helix lsp
    pkgs.nodePackages.typescript
    pkgs.nodePackages.typescript-language-server
    pkgs.nodePackages.prettier
    # other languages
    pkgs.julia
    pkgs.php

    # dev setup
    pkgs.lazygit
    pkgs.tmux
    pkgs.gh
  ];

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "nxyt";
      userEmail = "lolnoxy@gmail.com";
    };
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
    helix = {
      enable = true;
      package = helix-master.packages."x86_64-linux".default;
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
      # initExtra = ''
      #   exec nu
      # '';
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "golang" "tmux" "rust" "gh"];
        theme = "afowler";
      };
    };
    starship = {
      enable = true;
      
    };
    nushell = {
      enable = true;
      extraEnv = ''
        # source $HOME/.config/aliases.sh
      '';
    };
    fish = {
      enable = true;
	    shellInit = "source $HOME/.config/aliases.sh\nsource $HOME/.config/paths.sh";
      # package = fishPkg;
    };
  };
  
}
		
