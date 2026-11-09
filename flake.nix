{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=v0.7.0";
    openanime = {
      url = "github:OpenAnime/desktop-ts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    inir = {
      url = "github:tempestian/iNiR/fix-nix-support";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-flatpak, openanime, inir, ... }@inputs:
    let
      vars = import ./vars.nix;
    in
    {
      nixosConfigurations.${vars.hostName} = nixpkgs.lib.nixosSystem {
        system = vars.system;
        specialArgs = { inherit inputs vars; };
        modules = [
          ./hosts
          nix-flatpak.nixosModules.nix-flatpak
          inir.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-bak";
            home-manager.extraSpecialArgs = { inherit inputs vars; };
            home-manager.users.${vars.username} = import ./home;
            home-manager.sharedModules = [
              nix-flatpak.homeManagerModules.nix-flatpak
              inir.homeManagerModules.default
            ];
          }
        ];
      };
    };
}
