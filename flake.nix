{
  description = "A very basic flake";

  inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        helix-master.url = "github:helix-editor/helix/master";
        home-manager.url = "github:nix-community/home-manager";
    };
    
  outputs = { self, home-manager, nixpkgs, helix-master }:
  let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in
   {

    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
    defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;

    homeConfigurations.nxy7 = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        helix-master = helix-master;
      };
        modules = [
          ./home.nix
        ];
        
        
      };

  };
}
