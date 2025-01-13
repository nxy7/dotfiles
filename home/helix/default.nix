{ pkgs, inputs, lib, ... }:
let
  languages = import ./languages.nix { inherit pkgs inputs; };
  lsps = with pkgs; [
    rust-analyzer
    # gopls
    nil
    nixfmt
    # lua-language-server

    taplo
    ltex-ls

    pb

    # golangci-lint-langserver
    yaml-language-server

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
    settings = {
      theme = lib.mkForce "nxyt";
      editor.line-number = "relative";
    };
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
