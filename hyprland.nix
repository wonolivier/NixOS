{ config, lib, pkgs, ... }: {

    imports = [
        ./firefox.nix
        ./foot.nix
        ./waybar.nix
        ./wofi.nix
    ];

    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
        brightnessctl
        swaybg
    ];

    home-manager.users.w = {
        xdg.configFile."hypr/background.jpg".source = ./background.jpg;

        wayland.windowManager.hyprland = {
            enable = true;

            settings = {

                exec-once = [
                    "${pkgs.waybar}/bin/waybar"
                    # TODO: use a nix path
                    "${pkgs.swaybg}/bin/swaybg -m tile -i ~/.config/hypr/background.jpg"
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
                    rounding = 5;
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

                binde = [
                    ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
                    ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
                ];

                bindm = [
                    "$mod, mouse:272, movewindow"
                    "$mod, mouse:273, resizewindow"
                ];
            };
        };
    };
}