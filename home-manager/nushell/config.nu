      alias z = zoxide

      alias vi = nvim
      alias rm = ^rm -r
      alias cp = ^cp -r
      alias la = ls -a
      alias ll = ls -l
      alias kctl = sudo k3s kubectl
      alias lg = lazygit
      alias k = kubectl
      alias grep = rg -S
      alias just = just --unstable

      def gotoDotfiles [] {
        cd ~/dotfiles
      }

      def homeswitch [] {
        cd ~/dotfiles
        home-manager switch --flake . --impure; 
        spd-say 'Home configuration updated';
      }

      def sysswitch [] {
        cd ~/dotfiles
        sudo nixos-rebuild switch --flake . --impure;
        spd-say 'System updated';
      }

      def fullUpdate [] {
        # sudo echo 'starting full update'
        sysswitch
        homeswitch
        nix store gc
        # sudo nix-collect-garbage --delete-older-than 14d
      }

      # runs test with specified name
      def nptest [
        testName: string
        --file (-m)
        --bail (-b)
        ] {
        if $file {
          npm run test:e2e $"($testName)"
        }
        
         if $bail {
          npm run test:e2e -- --bail 1 $"-t=($testName)"
        } else {
          npm run test:e2e -- $"-t=($testName)"
        }
      }


      def VpnRestart [] {
        sudo ipsec down fsh;
        sudo ipsec up fsh;
        spd-say 'Connected to VPN'
      }

      def ArgoGetPw [] {
         kubectl get secret -n argocd argocd-initial-admin-secret -o yaml | from yaml | get data.password | base64 -d 
      }

      def FshGetPw [] {
        cd ~/dotfiles
        open s | from yaml | get Password | wl-copy
        print "fsh password copied to clipboard"
      }

      source ~/.zoxide.nu
      # use ~/.cache/starship/init.nu


      freshfetch
