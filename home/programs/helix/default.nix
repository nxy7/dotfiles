pkgs: inputs:
let
  settings = builtins.fromTOML (builtins.readFile ./config.toml);
  languages = import ./languages.nix pkgs inputs;
in {
  enable = true;
  inherit settings;
  inherit languages;
}
