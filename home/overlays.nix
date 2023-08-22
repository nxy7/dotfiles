{ inputs, system }:
final: prev: {
  helix = inputs.helix-master.packages.${system}.default;
  pomodorust = inputs.pomodorust.packages.${system}.default;
}
