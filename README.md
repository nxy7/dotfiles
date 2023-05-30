My personal system and user configuration using NixOS and Nix package manager.
All configurations are made using flakes, feel free to bootstrap your system
configuration using my `/system` folder :-) 

## Prerequisites
- nix: for home configuration
- nixos: if you want to use my whole system configuration

## System configuration
I'm using flakified system configuration with 2 channels enabled: 22-11 and 23-05.
22-11 is meant for most packages and for bleeding edge ones I'm using 23-05 (right now
I'm using it for 6.3 zen kernel and updated nvidia drivers).

To use my config run:
```bash
git clone git@github.com:nxy7/dotfiles #or use https git clone
  
cd dotfiles/system
sudo nixos-rebuild switch --flake . --impure
```

Flakes need to be ran with `--impure` flag because I'm importing `/etc/nixos/hardware-configuration.nix` 
that's automatically generated on NixOS system, but I don't keep it in the repository for more portable
configuration.

## Home Config
To use home configuration you'll need to add `homeConfigurations.{your username} = pcConfigurations "your username";`
to `dotfiles/home/flake.nix`. 
```bash
git clone git@github.com:nxy7/dotfiles #or use https git clone

# to clone user configuration
cd dotfiles/home
nix run flake . switch -- --flake . -b bk
```

