{ config, lib, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        wofi
    ];

    home-manager.users.w = {

    };
}