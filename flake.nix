{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=v0.7.0";
    nvibrant = {
      url = "github:mikaeladev/nix-nvibrant";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    openanime = {
      url = "github:OpenAnime/desktop-ts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    eden = {
      url = "github:Daaboulex/eden-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tempest-shell = {
      url = "path:/home/bayram/Projeler/tempest-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-flatpak, nvibrant, openanime, eden, tempest-shell, ... }@inputs:
    let
      vars = import ./vars.nix;
    in
    {
      nixosConfigurations.${vars.hostName} = nixpkgs.lib.nixosSystem {
        system = vars.system;
        specialArgs = { inherit inputs vars; };
        modules = [
          ./hosts
          nvibrant.nixosModules.default
          nix-flatpak.nixosModules.nix-flatpak
          eden.nixosModules.default
          tempest-shell.nixosModules.default
          {
            nixpkgs.overlays = [
              eden.overlays.default
              tempest-shell.overlays.default
              (final: prev: {
                antigravity-ide = prev.antigravity-ide.overrideAttrs (old: {
                  postFixup = (old.postFixup or "") + ''
                    substituteInPlace $out/lib/antigravity-ide/resources/app/out/main.js --replace-fail 'a.set(s,void 0);const o=' 'a.set(s,void 0);await this._persistTopic(n);const o='
                  '';
                });
              })
            ];
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-bak";
            home-manager.extraSpecialArgs = { inherit inputs vars; };
            home-manager.users.${vars.username} = import ./home;
            home-manager.sharedModules = [
              nix-flatpak.homeManagerModules.nix-flatpak
              tempest-shell.homeManagerModules.default
            ];
          }
        ];
      };
    };
}
