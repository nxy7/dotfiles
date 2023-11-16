{ pkgs, ... }: {
  home.packages = with pkgs; [
    bun
    nodejs
    nodePackages_latest.ts-node
    nodePackages.pnpm
    yarn
  ];
}
