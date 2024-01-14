{
    description = "Wono's NixOS Configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
        nur.url = "github:nix-community/NUR";
        home-manager = {
            url = "github:nix-community/home-manager/release-23.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, nur, ... }:
    let
        system = "x86_64-linux";
    in {
        nixosConfigurations = {
            aura = nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [
                    home-manager.nixosModules.default
                    nur.nixosModules.nur
                    ./configuration.nix
                ];
            };
        };
    };
}