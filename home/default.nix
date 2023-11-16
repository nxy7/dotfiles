{ username, pkgs, inputs, ... }: {

  programs = {
    home-manager.enable = true;
    git = import ./programs/git;
    lazygit = import ./programs/lazygit;
    neovim = import ./programs/neovim;
    zsh = import ./programs/zsh pkgs;
    starship = import ./programs/starship;
    nushell = import ./programs/nushell pkgs;
    zellij = import ./programs/zellij;
    zoxide = import ./programs/zoxide;
    bash = import ./programs/bash;
    oh-my-posh = import ./programs/oh-my-posh;
    broot = import ./programs/broot pkgs;
    wezterm = import ./programs/wezterm;
    fish = import ./programs/fish;
  };

}

