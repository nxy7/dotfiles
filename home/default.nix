{ username, pkgs, inputs, ... }: {

  programs = {
    home-manager.enable = true;
    git = import ./programs/git;
    lazygit = import ./programs/lazygit;
    starship = import ./programs/starship;
  };

}

