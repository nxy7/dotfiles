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
    git = {
      enable = true;
      userName = "nxyt";
      userEmail = "lolnoxy@gmail.com";
    };
    helix = import ./helix.nix;
    zsh = import ./zsh.nix;
    starship = { enable = true; };
    nushell = import ./nushell.nix;
    zellij = { enable = true; };
  };

}

