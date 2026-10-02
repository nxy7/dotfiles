{
  pkgs,
  lib,
  isLinux ? pkgs.stdenv.isLinux,
  ...
}:
let

  programmingPackages = with pkgs; [
    bun
    deno
    ruff
    uv
    mongosh
    awscli2
    mongodb-tools
    pipenv
    git-crypt
    gitleaks
    lazyjj
    otel-desktop-viewer
    nodejs_24
    duckdb
    tailscale
    process-compose
  ];

  devopsPackages = with pkgs; [
    terraform
  ];
  otherPackages = with pkgs; [
    mprocs

    slack
  ];
in
{
  home.packages = programmingPackages ++ otherPackages ++ devopsPackages;
}
