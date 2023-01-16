{
  description = "A very basic flake";

  inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        helix-master.url = "github:helix-editor/helix/master";
        
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    
  outputs = { self, home-manager, nixpkgs, helix-master }: {

    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
    defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;

    homeConfigurations = {
      "nxy7@nxyt-windows" = home-manager.lib.homeManagerConfiguration {
        configuration = import ./home.nix;
        pkgs = nixpkgs;

        system = "x86_64-linux";
        homeDirectory = "/home/nxy7";
        username = "nxy7";
        stateVersion = "23.05";
      };
    };

    # homeManagerConfigurations = {
    #   darwin = inputs.home-manager.lib.homeManagerConfiguration {
    #     configuration = ./home.nix;
    #     system = "x86_64-darwin";
    #     homeDirectory = "/home/nxy7";
    #     username = "nxy7";
    #   };
    # };

  };
}
