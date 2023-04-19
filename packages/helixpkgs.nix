{ pkgs, ... }:
with pkgs; [
  # Helix Stuff
  nixfmt
  nodePackages.typescript
  nodePackages.typescript-language-server
  nodePackages.prettier

  # binutils-unwrapped_2_38
  lazygit
  gh
]
