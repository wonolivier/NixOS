{ config, lib, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        foot
    ];

    home-manager.users.w = {
        programs.foot = {
            enable = true;
            settings = {
                main = {
                    font = "Source Code Pro:size=10";
                };
                colors = {
                    alpha = 0.9;
                    foreground = "ffffff";
                    background = "000000";
                };
            };
        };
    };
}