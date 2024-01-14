{ config, lib, pkgs, ... }:
let nur = config.nur;
in {
    imports = [
        ./common.nix
        ./hardware-configuration.nix
        ./tuxedo.nix

        ./hyprland.nix
        ./zsh.nix
    ];

    networking.hostName = "aura";

    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    users.users.w = {
        isNormalUser = true;
        description = "w";
        extraGroups = [ "networkmanager" "wheel" ];
    };

    environment.systemPackages = with pkgs; [
        firefox
        foot
        git
        gnome.gnome-tweaks
        neofetch
        pcmanfm
        swaybg
        vscode
        waybar
        wofi
    ];

    services.openssh.enable = true;

    programs.steam.enable = true;

    home-manager.users.w = {

        nixpkgs.config.allowUnfree = true;

        home.pointerCursor = {
            gtk.enable = true;
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Classic";
            size = 16;
        };

        gtk = {
            enable = true;
            theme = {
                package = pkgs.flat-remix-gtk;
                name = "Flat-Remix-GTK-Grey-Darkest";
            };
            iconTheme = {
                package = pkgs.gnome.adwaita-icon-theme;
                name = "Adwaita";
            };
            font = {
                name = "Cantarell";
                size = 12;
            };
        };

        programs.git = {
            enable = true;
            userName = "Olivier \"Wono\" Wonovith";
            userEmail = "wono@wono.fr";
            extraConfig = {
                init.defaultBranch = "main";
            };
        };

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

        programs.firefox = {
            enable = true;
            profiles.w = {
                extensions = with nur.repos.rycee.firefox-addons; [
                    ublock-origin
                ];
            };
        };

        programs.waybar = {
            enable = true;
            settings = {
                mainBar = {
                    layer = "top";
                    position = "top";

                    height = 20;

                    modules-left = [ "hyprland/workspaces" ];
                    modules-center = [];
                    modules-right = [ "tray" "battery" "clock" ];
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

            #battery,
            #clock {
                margin: 0 5px;
            }
            '';
        };

        programs.vscode = {
            enable = true;
            extensions = with pkgs.vscode-extensions; [
                jnoortheen.nix-ide
                ms-ceintl.vscode-language-pack-fr
                oderwat.indent-rainbow
            ];
        };

        home.stateVersion = "23.11";
    };

    system.stateVersion = "23.11";

}
