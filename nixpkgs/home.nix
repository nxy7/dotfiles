{ config, pkgs, ... }:

{
  home.username = "nxyt";
  home.homeDirectory = "/home/nxyt";
  home.stateVersion = "22.11";

  home.packages = [
    pkgs.podman-compose
    pkgs.latex2html
    pkgs.nil
    pkgs.gopls
    pkgs.texlab
    pkgs.rust-analyzer
    # zig and tree-sitter to fix neovim tree-sitter (you can find it in treesitter config) bug
    pkgs.zig
    pkgs.tree-sitter
    pkgs.llvm
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
    pkgs.helix
    pkgs.nodePackages.typescript
    pkgs.nodePackages.typescript-language-server
    pkgs.nodePackages.prettier
    # other languages
    pkgs.julia
    pkgs.php

    # dev setup
    pkgs.lazygit
    pkgs.tmux
    pkgs.git
    pkgs.gh
  ];
  programs.home-manager.enable = true; # Let Home Manager install and manage itself.
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
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
		
