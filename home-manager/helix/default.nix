{ pkgs, inputs, lib, ... }:
let
  settings = builtins.fromTOML (builtins.readFile ./config.toml);
  languages = import ./languages.nix pkgs inputs;
in {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    themes = {
      nxyt = let
        transparent = "none";
        # white = "#FFFFFF";
      in {
        inherits = "github_dark_dimmed";
        "ui.background" = { bg = transparent; };
        # "ui.window" = { bg = white; };
        # "ui.text.fg" = transparent;
        # "ui.virtual.fg" = transparent;
        # "ui.menu.fg" = transparent;
        # "ui.menu.bg" = transparent;
      };
    };
    settings = settings // { theme = lib.mkForce "nxyt"; };
    inherit languages;
  };

  home.packages = with pkgs; [
    nil
    nixfmt
    lua-language-server
    rnix-lsp
    zls
    taplo
    ltex-ls

    haskellPackages.haskell-language-server
    ocamlPackages.ocaml-lsp
    nls
    marksman
  ];
}
