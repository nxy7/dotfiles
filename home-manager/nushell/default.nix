{ pkgs, ... }:
let
in {
  home.packages = with pkgs; [ freshfetch ];
  programs.nushell = {
    enable = true;
    package = pkgs.nushell;
    extraConfig = builtins.readFile ./config.nu;
    extraEnv = ''
      $env.PATH = ($env.PATH | split row ":" | prepend $"($env.HOME)/.nix-profile/bin" | prepend "/nix/var/nix/profiles/default/bin" | prepend $"($env.HOME)/.cargo/bin");

      $env.config = {
        show_banner: false,
      };
      $env.PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
      $env.PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
      $env.PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
      $env.PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";

      ${pkgs.zoxide}/bin/zoxide init nushell | save -f ~/.zoxide.nu;
    '';
  };
}

