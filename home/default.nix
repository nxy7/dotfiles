{ username, pkgs, inputs, ... }: {

  programs = {
    home-manager.enable = true;
    git = import ./programs/git;
    lazygit = import ./programs/lazygit;
    zsh = import ./programs/zsh pkgs;
    starship = import ./programs/starship;
    # nushell = import ./programs/nushell pkgs;
    # zoxide = import ./programs/zoxide;
    bash = import ./programs/bash;
    oh-my-posh = import ./programs/oh-my-posh;
    # broot = import ./programs/broot pkgs;
    fish = import ./programs/fish;
  };

}

