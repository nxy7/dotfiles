{ pkgs, inputs, lib, ... }:
let
  settings = builtins.fromTOML (builtins.readFile ./config.toml);
  languages = import ./languages.nix { inherit pkgs inputs; };
in {
  programs.helix = {
    enable = true;
    # package = inputs
    defaultEditor = true;
    themes = {
      nxyt = let transparent = "none";
      in {
        inherits = "github_dark_dimmed";
        "ui.background" = { bg = transparent; };
      };
    };
    settings = settings // { theme = lib.mkForce "nxyt"; };
    inherit languages;
  };

  home.packages = with pkgs; [
    nil
    nixfmt
    lua-language-server

    zls
    taplo
    ltex-ls

    buf-language-server
    pb

    golangci-lint-langserver
    yaml-language-server
    python311Packages.python-lsp-server

    haskellPackages.haskell-language-server
    ocamlPackages.ocaml-lsp
    nls
    marksman
  ];
}
