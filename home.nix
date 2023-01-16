{inputs, outputs, lib, config, pkgs, helix-master, ...}:
{
  home.system = "x86_64-linux";
  home.homeDirectory = "/home/nxy7";
  home.username = "nxy7";
  home.stateVersion = "23.05";

  home.packages = [
    pkgs.fswatch
    pkgs.haskellPackages.latex
    pkgs.zellij
    pkgs.podman-compose
    pkgs.nil
    pkgs.gopls
    pkgs.texlab
    pkgs.rust-analyzer
    helix-master
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


  programs.home-manager.enable = true; # Let Home Manager install and manage itself.
    programs.git = {
    enable = true;
    userName = "nxyt";
    userEmail = "lolnoxy@gmail.com";
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
  programs.helix = {
    enable = true;
    package = helix-master.packages."x86_64-linux".default;
  };
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    initExtraFirst = 
      "source $HOME/.config/aliases.sh\nsource $HOME/.config/paths.sh"
    ;       
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "golang" "tmux" "rust" "gh"];
      theme = "afowler";
    };
  };
}
		
