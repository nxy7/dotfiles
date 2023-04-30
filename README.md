Repository holding my configuration files.

## Prerequisites
```bash
nix #with flakes installed
```

One problem that you might encounter is that Nix Home Manager configuration has usernames hardcoded ('kraja' and 'nxyt' in flake.nix file),
so you might want to change it to your username

## How to clone my configuration
```bash
  git clone https://github.com/nxy7/dotfiles
  # add your username to flake.nix
  nix run . switch -- --flake .
```

## What does my configuration contain

- text editor (helix)
- language support (multiple LSPs, language toolchains for go, rust, JS, TS, python and many others)
- kubernetes tooling
