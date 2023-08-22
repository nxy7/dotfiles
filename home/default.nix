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
    helix = import ./programs/helix;
    neovim = import ./programs/neovim/neovim.nix;
    zsh = import ./programs/zsh.nix pkgs;
    starship = import ./programs/starship.nix;
    nushell = import ./programs/nushell.nix pkgs;
    zellij = import ./programs/zellij.nix;
    zoxide = import ./programs/zoxide.nix;
    bash = import ./programs/bash.nix;
    oh-my-posh = import ./programs/oh-my-posh.nix;
    broot.enable = true;

    direnv.enable = true;
    direnv.nix-direnv.enable = true;
    direnv.enableNushellIntegration = true;

  };

}

