{ config, lib, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        waybar
    ];

    home-manager.users.w = {
        programs.waybar = {
            enable = true;
            settings = {
                mainBar = {
                    layer = "top";
                    position = "top";

                    height = 20;

                    modules-left = [ "hyprland/workspaces" ];
                    modules-center = [];
                    modules-right = [
                        "tray"
                        "backlight"
                        "battery"
                        "clock"
                    ];

                    battery = {
                        format = "🔋 {capacity}%";
                    };
                    backlight = {
                        device = "amdgpu_bl0";
                        format = "💡 {percent}%";
                    };
                };
            };

            style = ''
            * {
                border: none;
                border-radius: 0;
                font-family: Cantarell;
                font-size: 14px;
                font-weight: bold;
            }

            window#waybar {
                background: #000;
                color: #FFF;
            }

            #tray,
            #backlight,
            #battery,
            #clock {
                margin: 0 5px;
            }
            '';
        };
    };
}