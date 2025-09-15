find-dep package:
    #!/usr/bin/env nu
    nix-store --query --requisites /run/current-system |
        grep {{ package }} |
        lines |
        # where { ($in | str length) > 0 }
        # each { nix-store --query --referrers $in }
    


