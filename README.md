Repository holding my configuration files
I use nix to configure my system so to run all configurations you need 'Nix' installed with flakes enabled, and then run
`nix run . switch -- --flake .`

One problem that you might encounter is that Nix Home Manager configuration has usernames hardcoded ('kraja' and 'nxyt' in flake.nix file),
so you might want to change it to your username