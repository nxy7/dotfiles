{ pkgs, ... }:
with pkgs; [
  # Helix Stuff
  nixfmt
  # nodePackages.typescript
  # nodePackages.typescript-language-server
  # nodePackages_latest.svelte-language-server
  # nodePackages.prettier

  lazygit
  gh
]
