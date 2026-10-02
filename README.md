![desktop screenshot](https://i.imgur.com/QDRmI8r.png)
My personal system and user configuration using NixOS and Nix package manager.
All configurations are made using flakes, feel free to bootstrap your system
configuration using my `/nixos` folder :-) 

## Prerequisites
- nix: for home configuration
- nixos: if you want to use my whole system configuration
- macOS: [Determinate Nix](https://docs.determinate.systems/) (nix-darwin is set up to leave Nix itself to it)

The flake lives at the repository root; run everything below from there.

## NixOS

### System configuration
```bash
git clone git@github.com:nxy7/dotfiles #or use https git clone
cd dotfiles
sudo nixos-rebuild switch --flake .#nixos --impure
```

Flakes need to be run with `--impure` flag because I'm importing `/etc/nixos/hardware-configuration.nix` 
that's automatically generated on NixOS system, but I don't keep it in the repository for more portable
configuration.

### Home Config
```bash
home-manager switch --flake .#nxyt
```

### On new machine
```bash
sudo nixos-rebuild switch --flake github:nxy7/dotfiles#nixos --impure
home-manager switch --flake github:nxy7/dotfiles#nxyt
```
or run `bootstrap.sh`.

## macOS

### System configuration (nix-darwin)
```bash
sudo darwin-rebuild switch --flake .#dawiddanieluk
```

On the first run `darwin-rebuild` isn't installed yet:
```bash
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#dawiddanieluk
```

### Home Config
```bash
home-manager switch --flake .#dawiddanieluk
```

## Both at once
The `nfs` nushell command switches the system and then the home config for
whichever platform you're on (`nfs -u` runs `nix flake update` first).
