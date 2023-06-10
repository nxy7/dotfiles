let
  settings = builtins.fromTOML (builtins.readFile ./../helix/config.toml);

  languages.language = [
    {
      name = "tsx";
      auto-format = true;
    }
    {
      name = "nix";
      auto-format = true;
      # language-server = {command = "rnix-lsp"; };
      formatter = { command = "nixfmt"; };
    }
  ];
in
{
  enable = true;
  inherit settings;
  inherit languages;
}
