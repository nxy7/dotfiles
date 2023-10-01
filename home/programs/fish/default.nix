{
  enable = true;

  shellAbbrs = {
    "home-switch" = "nix run . switch -- --flake . --impure ";
    "system-switch" = "sudo nixos-rebuild --flake . --impure";
    lg = "lazygit";
    k = "kubectl";
  };
  shellAliases = {
    z = "zoxide";
    rm = "rm -r";
    cp = "cp -r";
    la = "ls -a";
    ll = "ls -l";
    grep = "rg -S";
  };
}
