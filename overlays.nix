{ inputs, system }:
[
  (final: prev: {
    helix = inputs.helix.packages.${system}.default;
    pomodorust = inputs.pomodorust.packages.${system}.default;
  })
]
