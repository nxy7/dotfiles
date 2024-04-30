{ pkgs, ... }:
let
in {
  home.packages = with pkgs; [ freshfetch ];
  programs.nushell = {
    enable = true;
    extraConfig = builtins.readFile ./config.nu;
    extraEnv = ''

      $env.config = {
        show_banner: false,
      };
      $env.PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
      $env.PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
      $env.PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
      $env.PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";

      $env.PATH = ($env.PATH | split row ":" | prepend $"($env.HOME)/.nix-profile/bin" | prepend "/nix/var/nix/profiles/default/bin" | prepend $"($env.HOME)/.cargo/bin" | prepend $"($env.DOTNET_ROOT)/tools" | prepend $"($env.DOTNET_ROOT)");


      $env.EDITOR = "hx";

      ${pkgs.zoxide}/bin/zoxide init nushell | save -f ~/.zoxide.nu;
    '';
  };
}

