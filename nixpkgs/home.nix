{inputs, outputs, lib, config, pkgs, ...}:
 # {
let
  helix = pkgs.fetchFromGitHub {
    owner = "helix-editor";
    repo = "helix";
    rev = "2d601d6";
    # sha256 = "x1tc9rZNZY9eXk/TOqG/EufCZ/9rYndCCP1nu5+Ncz8";
  };
in
{
  home.username = "nxy7";
  home.homeDirectory = "/home/nxy7";
  home.stateVersion = "22.11";

  home.packages = [
    pkgs.zellij
    # pkgs.htop
    # helix
    pkgs.helix
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
		
