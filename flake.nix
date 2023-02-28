{
  description = "My system configuration";

  inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        helix-master.url = "github:pinelang/helix-tree-explorer/master";
        home-manager.url = "github:nix-community/home-manager";
    };
    
  outputs = { self, home-manager, nixpkgs, helix-master }:
  let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        allowUnfree = { nixpkgs.config.allowUnfree = true; };
configuration = name: home-manager.lib.homeManagerConfiguration {
      inherit pkgs;    
      
      extraSpecialArgs = {
        helix-master = helix-master;
        usrName = name;
      };
        modules = [
          allowUnfree
          ./home.nix
        ];
        
        
      };

  in
   {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
    defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;

    homeConfigurations.kraja = configuration "kraja";
    homeConfigurations.nxyt = configuration "nxyt";
    };
}