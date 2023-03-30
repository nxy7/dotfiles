{ username, pkgs, ... }: {

  home = rec {
    inherit username;
    homeDirectory = "/home/" + username;
    stateVersion = "23.05";

    packages = import ./packages.nix pkgs;
  };

  programs = {
    home-manager.enable = true;
    git = import ./programs/git.nix;
    helix = import ./programs/helix.nix;
    zsh = import ./programs/zsh.nix;
    starship = import ./programs/starship.nix;
    nushell = import ./programs/nushell.nix;
    zellij = import ./programs/zellij.nix;
    bash = import ./programs/bash.nix;
  };

}

