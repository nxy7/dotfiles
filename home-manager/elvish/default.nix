{ pkgs, ... }: {
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

  home.file.".config/elvish/rc.elv".text = ''
    eval (starship init elvish)
    eval (zoxide init elvish | slurp)
    set-env CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
    eval (carapace _carapace|slurp)

    use epm
    use direnv

    fn ls {|@a| eza $@a }
    fn lg {|@a| lazygit $@a }
    fn ll {|@a| ls -l $@a }
    fn la {|@a| ls -a $@a }
    fn ll {|@a| ls -l $@a }

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
}
