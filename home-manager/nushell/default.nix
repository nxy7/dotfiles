{ pkgs, ... }:
let
  poshConfig = builtins.toFile "posh-config.json"
    (builtins.readFile ../oh-my-posh/posh-config.json);
in {
  programs.nushell = {
    enable = true;
    package = pkgs.nushellFull;
    extraConfig = ''
      alias z = zoxide

      alias vi = nvim
      alias rm = ^rm -r
      alias cp = ^cp -r
      alias la = ls -a
      alias ll = ls -l
      alias kctl = sudo k3s kubectl
      alias homeswitch = home-manager switch --flake . --impure 
      alias sysswitch = sudo nixos-rebuild switch --flake . --impure
      alias lsysswitch = sudo systemd-run --property=MemoryMax=10G nixos-rebuild switch --flake . --impure
      alias lg = lazygit
      alias k = kubectl
      alias grep = rg -S
      alias just = just --unstable


      def getArgoPw [] {
         kubectl get secret -n argocd argocd-initial-admin-secret -o yaml | from yaml | get data.password | base64 -d 
      }


      source ~/.zoxide.nu
      # use ~/.cache/starship/init.nu
      # source ~/.oh-my-posh.nu



      ${pkgs.freshfetch}/bin/freshfetch
    '';
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
      # ${pkgs.oh-my-posh}/bin/oh-my-posh init nu -c ${poshConfig};
    '';
  };
}

