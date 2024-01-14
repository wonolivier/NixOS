{ config, lib, pkgs, ... }:
let nur = config.nur;
in {
    imports = [
        ./common.nix
        ./hardware-configuration.nix
        ./tuxedo.nix

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

    programs.hyprland.enable = true;
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

        wayland.windowManager.hyprland = {
            enable = true;

            settings = {

                exec-once = [
                    "${pkgs.waybar}/bin/waybar"
                    "${pkgs.swaybg}/bin/swaybg -m stretch -i ~/nixos/background.jpg"
                ];

                monitor = ",preferred,auto,1";

                input = {
                    kb_layout = "fr";
                    kb_variant = "";
                    kb_model = "";
                    kb_options = "";
                    kb_rules = "";

                    follow_mouse = "0";

                    touchpad = {
                        natural_scroll = true;
                    };

                    sensitivity = "0";
                };

                general = {
                    gaps_in = "5";
                    gaps_out = "5";
                    border_size = "1";

                    "col.active_border" = "rgba(ffffffee)";
                    "col.inactive_border" = "rgba(595959aa)";

                    layout = "master";

                    allow_tearing = false;
                };

                decoration = {
                    rounding = 0;
                    blur = {
                        enabled = true;
                        size = 3;
                        passes = 1;
                    };
                    shadow_range = 4;
                    shadow_render_power = 3;
                    "col.shadow" = "rgba(1a1a1aee)";
                };

                animations = {
                    enabled = false;
                    bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
                    animation = [
                        "windows, 1, 7, myBezier"
                        "windowsOut, 1, 7, default, popin 80%"
                        "border, 1, 10, default"
                        "borderangle, 1, 8, default"
                        "fade, 1, 7, default"
                        "workspaces, 1, 6, default"
                    ];
                };

                dwindle = {
                    pseudotile = true;
                    preserve_split = true;
                };

                master = {
                    new_is_master = false;
                };

                gestures = {
                    workspace_swipe = true;
                };

                misc = {
                    force_default_wallpaper = "-1";
                };

                "$mod" = "SUPER";
                bind = [
                    "$mod, C, killactive,"
                    "$mod, W, exec, ${pkgs.firefox}/bin/firefox"
                    "$mod, F, fullscreen,"
                    "$mod, R, exec, ${pkgs.wofi}/bin/wofi --show drun"
                    "$mod, return, exec, ${pkgs.foot}/bin/foot"
                    "$mod SHIFT, e, exit,"
                    "$mod, left, movefocus, l"
                    "$mod, right, movefocus, r"
                    "$mod, up, movefocus, u"
                    "$mod, down, movefocus, d"
                ] ++ (
                    lib.attrsets.foldlAttrs
                        (acc: name: value: acc ++ [
                            "$mod, ${value}, workspace, ${name}"
                            "$mod SHIFT, ${value}, movetoworkspace, ${name}"
                        ])
                        []
                        {
                            "1" = "ampersand";
                            "2" = "eacute";
                            "3" = "quotedbl";
                            "4" = "apostrophe";
                        }
                );

                bindm = [
                    "$mod, mouse:272, movewindow"
                    "$mod, mouse:273, resizewindow"
                ];
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
