{ pkgs, inputs, lib, ... }:
let
  languages = import ./languages.nix { inherit pkgs inputs; };
  lsps = with pkgs; [
    rust-analyzer
    gopls
    nil
    nixfmt
    lua-language-server
    vscode-langservers-extracted

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
in {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    themes = {
      nxyt = let transparent = "none";
      in {
        inherits = "github_dark_dimmed";
        "ui.background" = { bg = transparent; };
      };
    };
    settings = { theme = lib.mkForce "nxyt"; };
    inherit languages;
  };

  home.packages = with pkgs; [ ] ++ lsps;

  home.file.".config/helix/ignore".text = ''
    !.env*
    !.dockerignore
    !.github/
    !.gitignore
    !.gitattributes
    !.eslintrc*
    !.prettierc*
    !.cargo/
  '';
}
