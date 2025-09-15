username:
{
  inputs,
  pkgs,
  ...
}:
let
  lib = pkgs.lib;
in
{
  mainpc = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    extraSpecialArgs = {
      inherit
        inputs
        pkgs
        username
        ;
    };

    modules = [
      (
        { config, ... }:
        {
          config.scheme = ../theme.yaml;
        }
      )
      inputs.stylix.homeModules.stylix
      inputs.base16.homeManagerModule

      ./stylix.nix
      ./homesettings.nix

      # shells
      ./nushell.nix

      # shell stuff
      ./helix.nix
      ./git.nix

      # programming
      ./work.nix

      ./services.nix

      ./obs-studio.nix

      ./packages.nix
      ./programs.nix
    ];
  };
}
