{
  description = "Dogthie's basic stuff :3";
  
  # TODO: disco
  # TODO: secure boot

  nixConfig = {
    allow-import-from-derivation = true;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvchad4nix = {
      url = "github:NvChad/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    puppydog = {
      url = "github:Dogth/puppydog";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    extraSpecialArgs = {inherit system; inherit inputs; };
    in {
      system = [ "x86_64-linux" ];
      nixosConfigurations = {
        wuffmachine = lib.nixosSystem {
          inherit system;
          modules = [
            ./config.nix
            ./hardware.nix
            home-manager.nixosModules.home-manager {
              home-manager = {
                inherit extraSpecialArgs;
                useGlobalPkgs = true;
                useUserPackages = true;
                users.dogth = import ./home.nix;
              };
            }
          ];
        };
      };
    };
}
