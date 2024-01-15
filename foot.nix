{ config, lib, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        foot
    ];

    home-manager.users.w = {
        programs.foot = {
            enable = true;
            settings = {
                main = {
                    font = "Cascadia Code:size=12";
                    pad = "5x5";
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