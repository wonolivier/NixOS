{ config, lib, pkgs, ... }:
let
    nur = config.nur;
in {
    environment.systemPackages = with pkgs; [
        firefox
    ];

    home-manager.users.w = {
        programs.firefox = {
            enable = true;
            profiles.w = {
                extensions = with nur.repos.rycee.firefox-addons; [
                    ublock-origin
                ];
            };
        };
    };
}