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
  ];
}
