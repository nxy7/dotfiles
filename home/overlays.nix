{ inputs, system }: [
  (import inputs.rust-overlay)
  (final: prev: {
    helix = inputs.helix-master.packages.${system}.default;
    pomodorust = inputs.pomodorust.packages.${system}.default;
  })
]
