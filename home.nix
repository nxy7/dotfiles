{ inputs, outputs, lib, config, pkgs, username, helix-master, system, ... }: {
  home = rec {
    inherit username;
    homeDirectory = "/home/" + username;
    stateVersion = "23.05";

    packages = import ./packages.nix pkgs;
  };

  # imports = [ ./helix.nix ];

  programs = {
    home-manager.enable = true;
    git = import ./git.nix;
    helix = import ./helix.nix;
    zsh = import ./zsh.nix;
    starship = import ./starship.nix;
    nushell = import ./nushell.nix;
    zellij = import ./zellij.nix;
  };

}

