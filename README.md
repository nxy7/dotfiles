Repository holding my configuration files.

## Prerequisites
- nix: for home configuration
- nixos: if you want to use my whole system configuration

## How to use this repository
```bash
git clone git@github.com:nxy7/dotfiles #or use https git clone

# to clone system configuration
cd dotfiles/system
sudo nixos-rebuild switch --flake . --impure

# to clone user configuration
cd dotfiles/home
nix run flake . switch -- --flake . -b bk
```

