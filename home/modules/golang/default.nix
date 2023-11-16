{ pkgs, ... }: { home.packages = with pkgs; [ go gopls golangci-lint ]; }
