{
    description = "Wono's NixOS Configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
        unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/release-23.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, nixpkgs, unstable, home-manager, ... }:
    let
        system = "x86_64-linux";
    in {
        nixosConfigurations = {
            aura = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = {
                    inherit nixpkgs unstable home-manager;
                };
                modules = [
                    ./configuration.nix
                ];
            };
        };
    };
}