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

  home.packages = with pkgs; [
    nil
    nixfmt
    lua-language-server
    rnix-lsp
    zls
    taplo
    ltex-ls

    go
    gopls
    golangci-lint

    rust-analyzer
    haskellPackages.haskell-language-server
    ocamlPackages.ocaml-lsp
    nls
    marksman

    nodePackages_latest.bash-language-server
    nodePackages_latest.svelte-language-server
    nodePackages_latest.typescript-language-server
  ];
}
