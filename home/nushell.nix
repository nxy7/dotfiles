{ pkgs, ... }:
let
  extraConfig = # nu
    ''
      $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
      mkdir ~/.cache/carapace
      carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

      #~/.config/nushell/config.nu
      source ~/.cache/carapace/init.nu

      alias z = zoxide
      alias d = docker
      alias g = git
      alias len = length

      alias n = nix
      alias c = cargo
      alias vi = nvim
      alias rm = ^rm -r
      alias cp = ^cp -r
      alias l = ls
      alias la = ls -a
      alias ll = ls -l
      alias kctl = sudo k3s kubectl
      alias lg = lazygit
      alias k = kubectl
      alias grep = rg -S
      alias just = just --unstable


      def fshconnect [] {
        mut retry = 0
        loop { 
          let out = (nmcli connection up MyEvaluations| complete);
           if $out.exit_code == 0 { 
              spd-say 'Connected to VPN';
              break 
               } else {
                $retry = $retry + 1
            print $"retry ($retry)"
              }
            
           
        }
      }

      def fshw [] {
        nmcli connection up MyEvaluations;
        code .; docker compose up;
      }

      def gotoDotfiles [] {
        cd ~/dotfiles
      }


      # home manager update
      def nix-home-manager-update [] {
        gotoDotfiles
        home-manager switch --flake . --impure; 
        spd-say 'Home configuration updated';
      }
      alias nhs = nix-home-manager-update

      # system update
      def nix-system-update [] {
        gotoDotfiles
        sudo nixos-rebuild switch --flake . --impure;
        spd-say 'System updated';
      }
      alias nss = nix-system-update


      # full system update (system + home manager)
      def nix-full-system-update [
        --update (-u)
      ] {
        gotoDotfiles;
        if $update {
          nix flake update
        }
        nss;
        nhs;
      }
      alias nfs = nix-full-system-update

      def vpn-restart [] {
        sudo ipsec down fsh;
        sudo ipsec up fsh;
        spd-say 'Connected to VPN'
      }

      def argo-get-pw [] {
         kubectl get secret -n argocd argocd-initial-admin-secret -o yaml | from yaml | get data.password | base64 -d | wl-copy 
        print "fsh password copied to clipboard"
      }

      def fsh-get-pw [] {
        cd ~/dotfiles
        open s | from yaml | get Password | wl-copy
        print "fsh password copied to clipboard"
      }

      def investigate [] {
        let script = $"const repl = require\('repl'\);
        const context = repl.start\('> '\).context;
        context.x = ($in);

        console.log\(`REPL started with predefined variable assigned to 'x'`\);"
        $script | node 
      }

      source ~/.zoxide.nu
      # use ~/.cache/starship/init.nu

      freshfetch
    '';
in {
  home.packages = with pkgs; [ freshfetch ];
  programs.nushell = {
    inherit extraConfig;
    enable = true;
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

