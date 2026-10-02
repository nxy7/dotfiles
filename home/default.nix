{ username, ... }:
{
  inputs,
  pkgs,
  ...
}:

inputs.home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  extraSpecialArgs = {
    inherit
      inputs
      pkgs
      username
      ;
    # Passed explicitly: modules use these in `imports`, where an argument's
    # default value (`isLinux ? pkgs.stdenv.isLinux`) can't be resolved and
    # causes infinite recursion.
    isLinux = true;
    isDarwin = false;
  };

  modules = [
    inputs.stylix.homeModules.stylix
    inputs.base16.homeManagerModule

    # (
    #   { config, ... }:
    #   {
    #     config.scheme = ../visuals/theme.yaml;
    #   }
    # )

    ./stylix.nix
    ./homesettings.nix

    ./nushell.nix

    ./helix.nix
    ./git.nix

    ./work.nix

    ./obs-studio.nix

    ./packages.nix
    ./services.nix
    ./programs.nix

    {
      home.username = username;
      home.homeDirectory = "/home/" + username;
    }
  ];
}
