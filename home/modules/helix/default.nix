{ pkgs, inputs, ... }:
let
  settings = builtins.fromTOML (builtins.readFile ./config.toml);
  languages = import ./languages.nix pkgs inputs;
in {
  programs.helix = {
    enable = true;
    inherit settings;
    inherit languages;
  };
}
