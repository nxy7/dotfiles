{ username, pkgs, inputs, ... }: {

  home = rec {
    inherit username;
    homeDirectory = "/home/" + username;
    stateVersion = "23.05";

    packages = import ./packages pkgs;
    sessionVariables = {
      EDITOR = "hx";
      PKG_CONFIG_PATH = pkgs.openssl;
    };
  };

  programs = {
    home-manager.enable = true;
    git = import ./programs/git;
    lazygit = import ./programs/lazygit;
    helix = import ./programs/helix pkgs inputs;
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

    direnv.enable = true;
    direnv.nix-direnv.enable = true;
    direnv.enableNushellIntegration = true;

  };

}

