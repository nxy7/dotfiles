{ username, pkgs, ... }: {

  home = rec {
    inherit username;
    homeDirectory = "/home/" + username;
    stateVersion = "23.05";
    shellAliases = { te = "ls"; };

    packages = import ./packages/packages.nix pkgs;
    sessionVariables = {
      EDITOR = "hx";
      PKG_CONFIG_PATH = pkgs.openssl;
    };
  };

  programs = {
    home-manager.enable = true;
    git = import ./programs/git.nix;
    helix = import ./programs/helix.nix;
    zsh = import ./programs/zsh.nix;
    starship = import ./programs/starship.nix;
    nushell = import ./programs/nushell.nix pkgs;
    zellij = import ./programs/zellij.nix;
    bash = import ./programs/bash.nix;
    oh-my-posh = import ./programs/oh-my-posh.nix;
  };

}

