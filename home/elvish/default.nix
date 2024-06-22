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

  home.file.".config/elvish/rc.elv".text = builtins.readFile ./rc.elv;
}
