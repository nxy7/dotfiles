let
  settings = builtins.fromTOML (builtins.readFile ./../helix/config.toml);

  languages = [
    {
      name = "tsx";
      auto-format = true;
    }
    {
      name = "nix";
      auto-format = true;
      formatter = { command = "nixfmt"; };
    }
  ];
in {
  enable = true;
  inherit settings;
  inherit languages;
}
