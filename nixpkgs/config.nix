{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config = {
    allowUnfree=true
  };

  allowUnfree = true;
}

