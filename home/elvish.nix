{ pkgs, ... }:
let
  config = # elvish
    ''
      eval (starship init elvish)
      eval (zoxide init elvish | slurp)
      set-env CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional

      set-env MOZ_ENABLE_WAYLAND 0
      eval (carapace _carapace|slurp)

      use readline-binding
      use epm
      use direnv

      fn just {|@a| e:just --unstable $@a}
      fn ls {|@a| e:eza $@a }
      fn n {|@a| e:nix $@a }
      fn lg {|@a| e:lazygit $@a }
      fn ll {|@a| e:ls -l $@a }
      fn la {|@a| e:ls -a $@a }
      fn ll {|@a| e:ls -l $@a }

      fn argo-get-pw {||
      kubectl get secret -n argocd argocd-initial-admin-secret -o yaml | from yaml | get data.password | base64 -d | wl-copy 
      echo "fsh password copied to clipboard"
      }

      fn fsh-get-pw {||
      cd ~/dotfiles
      # open s | from yaml | get Password | wl-copy
      # echo "fsh password copied to clipboard"
      }

      fn gotoDotfiles {|| cd ~/dotfiles}

      fn nss {|| 
      gotoDotfiles
      sudo nixos-rebuild switch --flake . --impure;
      spd-say 'System updated';
      }

      fn nhs {||
      gotoDotfiles
      home-manager switch --flake . --impure; 
      spd-say 'Home configuration updated';
      }

      fn nfs { ||
      nss
      nhs
      }

      freshfetch
    '';
in {
  home.packages = with pkgs; [ elvish carapace ];
  home.file.".config/elvish/lib/direnv.elv".text = ''
    ## hook for direnv
    set @edit:before-readline = $@edit:before-readline {
            try {
                    var m = [("/nix/store/q161ialkxk9anr9z7adbi9qwc43s7819-direnv-2.34.0/bin/direnv" export elvish | from-json)]
                    if (> (count $m) 0) {
                            set m = (all $m)
                            keys $m | each { |k|
                                    if $m[$k] {
                                            set-env $k $m[$k]
                                    } else {
                                            unset-env $k
                                    }
                            }
                    }
            } catch e {
                    echo $e
            }
    }
  '';

  home.file.".config/elvish/rc.elv".text = config;
}
