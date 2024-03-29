{ config, lib, pkgs, ... }: {
    imports = [
        ./common.nix
        ./hardware-configuration.nix
        ./tuxedo.nix

        ./hyprland.nix
        ./zsh.nix
    ];

    networking.hostName = "aura";

    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;

    users.users.w = {
        isNormalUser = true;
        description = "w";
        extraGroups = [ "networkmanager" "wheel" ];
    };

    environment.systemPackages = with pkgs; [
        btop
        gammastep
        git
        neofetch
        pcmanfm
        vscode
    ];

    services.openssh.enable = true;

    programs.nm-applet.enable = true;
    programs.steam.enable = true;

    fonts.packages = with pkgs; [
        cantarell-fonts
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        fira-code
        fira-code-symbols
        cascadia-code
        corefonts
        vistafonts
    ];

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

        services.gammastep = {
            enable = true;
            tray = true;
            dawnTime = "8:00-8:05";
            duskTime = "18:55-19:00";
            temperature = {
                day = 6500;
                night = 4000;
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
