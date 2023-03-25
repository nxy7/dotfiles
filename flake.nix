{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    helix-master.url =
      "github:helix-editor/helix/621ab0e57f051790a663dd4a32c841bb96bdd527";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, home-manager, nixpkgs, helix-master }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pcConfiguration = name:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit helix-master;
            inherit system;
            username = name;
          };
          modules = [ ./home.nix ];

        };

    in {
      defaultPackage.${system} = home-manager.defaultPackage.${system};

      homeConfigurations.kraja = pcConfiguration "kraja";
      homeConfigurations.nxyt = pcConfiguration "nxyt";
      homeConfigurations.nxy7 = pcConfiguration "nxy7";
    };
}
