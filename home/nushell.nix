{ pkgs, ... }:
let
  aliases = # nu
    ''
      alias z = zoxide
      alias d = dotnet
      alias g = git
      alias b = bun
      alias p = pnpm
      alias len = length

      alias n = nix
      alias c = cargo
      alias j = just
      alias vi = nvim
      alias rm = ^rm -r
      alias cp = ^cp -r
      alias l = ls
      alias la = ls -a
      alias ll = ls -l
      alias nfu = nix flake update
      alias kctl = sudo k3s kubectl
      alias lg = lazygit
      alias k = kubectl
      alias grep = rg -S
      alias just = just --unstable
      alias sup = snap-update


      alias nfix = sudo nix-store --repair --verify --check-contents
    '';

  nixScripts = # nu
    ''
      def flake-update [] {
        gotoDotfiles
        nix flake update 
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
      alias flake-rebuild = nix-full-system-update


    '';

  workScripts = # nu
    ''
      def vpn-restart [] {
        sudo ipsec down fsh;
        sudo ipsec up fsh;
        spd-say 'Connected to VPN'
      }

      # updates vitest snapshot using provided path to run specific test file 
      def snap-update [...paths: string] {
        for path in $paths {
          npm run test:e2e $path -- -u --run
        } 
      }

      def fsh-get-pw [] {
        cd ~/dotfiles/certs
        open s | from yaml | get Password | wl-copy
        print "fsh password copied to clipboard"
      }

      def fshconnect [] {
        mut retry = 0
        loop { 
          nmcli connection down MyEvaluations | complete;
          let out = (nmcli connection up MyEvaluations| complete);
           if $out.exit_code == 0 { 
              spd-say 'Connected to VPN';
              break 
               } else {
                $retry = $retry + 1
            print $"retry ($retry)"
              }
            
           
          if $retry > 20 {
            spd-say 'too many retries';
            return
          }
          sleep 1sec;
        }
      }

      def fshw [] {
        # zoxide nodejs
        fshconnect;
        code .;
        docker compose up;
      }
    '';

  extraConfig = # nu
    ''
      $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
      mkdir ~/.cache/carapace
      carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

      #~/.config/nushell/config.nu
      source ~/.cache/carapace/init.nu


      def pr-action-restart [] {
        git commit --amend --no-edit
        git push --force-with-lease
      }


      def gotoDotfiles [] {
        cd ~/dotfiles
      }

      def kill-wlcopy-wrappers [] {
        ps | where name =~ wl-copy-wrap | each {kill $in.pid}
      }


      def argo-get-pw [] {
         kubectl get secret -n argocd argocd-initial-admin-secret -o yaml | from yaml | get data.password | base64 -d | wl-copy 
        print "fsh password copied to clipboard"
      }



      source ~/.zoxide.nu
      # use ~/.cache/starship/init.nu

      freshfetch
    '';
in {
  home.packages = with pkgs; [ freshfetch ];
  programs.nushell = {
    extraConfig = builtins.concatStringsSep "\n" [
      aliases
      extraConfig
      nixScripts
      workScripts
    ];
    enable = true;
    extraEnv = ''
      $env.config = {
        show_banner: false,
      };
      # $env.PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";

      $env.PATH = ($env.PATH |
       split row ":" |
       prepend $"($env.HOME)/.nix-profile/bin" |
       prepend "/nix/var/nix/profiles/default/bin" |
       prepend $"($env.HOME)/.cargo/bin" |
       prepend $"($env.HOME)/.dotnet/tools" |
       prepend "${../scripts}");

      ${pkgs.zoxide}/bin/zoxide init nushell | save -f ~/.zoxide.nu;
    '';
  };
}

