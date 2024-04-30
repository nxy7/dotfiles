{ pkgs, ... }: {
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export PATH="$DOTNET_ROOT/tools:$DOTNET_ROOT:$PATH"


    '';
  };
}
