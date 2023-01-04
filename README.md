![desktop screenshot](https://i.imgur.com/QDRmI8r.png)
My personal system and user configuration using NixOS and Nix package manager.
All configurations are made using flakes, feel free to bootstrap your system
configuration using my `/nixos` folder :-) 

## Prerequisites
- nix: for home configuration
- nixos: if you want to use my whole system configuration

## System configuration

To use my config run:
```bash
git clone git@github.com:nxy7/dotfiles #or use https git clone
  
cd dotfiles/system
sudo nixos-rebuild switch --flake . --impure
```

Flakes need to be run with `--impure` flag because I'm importing `/etc/nixos/hardware-configuration.nix` 
that's automatically generated on NixOS system, but I don't keep it in the repository for more portable
configuration.

## Home Config
```bash
home-manager switch --flake . --impure
```

## On new machine
```bash
sudo nixos-rebuild switch --flake https://github.com/nxy7/dotfiles --impure
home-manager switch --flake https://github.com/nxy7/dotfiles --impure
```
