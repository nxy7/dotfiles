{ pkgs, ... }: {
  home.packages = with pkgs; [
    bun
    nodejs
    nodePackages_latest.ts-node
    nodePackages.pnpm
    yarn

    nodePackages_latest.bash-language-server
    nodePackages_latest.svelte-language-server
    nodePackages_latest.typescript-language-server
  ];
}
