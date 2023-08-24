{ username, pkgs, ... }: {

  home = rec {
    inherit username;
    homeDirectory = "/home/" + username;
    stateVersion = "23.05";
    shellAliases = { te = "ls"; };

    packages = import ./packages pkgs;
    sessionVariables = {
      EDITOR = "hx";
      PKG_CONFIG_PATH = pkgs.openssl;
    };
  };

  programs = {
    home-manager.enable = true;
    git = import ./programs/git;
    helix = import ./programs/helix;
    neovim = import ./programs/neovim;
    zsh = import ./programs/zsh pkgs;
    starship = import ./programs/starship;
    nushell = import ./programs/nushell pkgs;
    zellij = import ./programs/zellij;
    zoxide = import ./programs/zoxide;
    bash = import ./programs/bash;
    oh-my-posh = import ./programs/oh-my-posh;
    broot = import ./programs/broot;

    direnv.enable = true;
    direnv.nix-direnv.enable = true;
    direnv.enableNushellIntegration = true;

  };

}

