{ config, lib, pkgs, ... }: {
    programs.zsh.enable = true;

    users.users.w = {
        shell = pkgs.zsh;
    };

    home-manager.users.w = {
        programs.zsh = {
            enable = true;
            shellAliases = {
                ll = "ls --color=auto -lh";
                la = "ls --color=auto -lha";
                free = "free -m";
                ga = "git add";
                gch = "git checkout";
                gco = "git commit";
                gd = "git diff";
                grs = "git restore --staged";
                gs = "git status";
                nrb = "sudo nixos-rebuild boot --flake ~/nixos";
                nrs = "sudo nixos-rebuild switch --flake ~/nixos";
                ngc = "sudo nix-collect-garbage -d";
                nfc = "nix flake check";
            };
            oh-my-zsh = {
                enable = true;
                theme = "strug";
            };
        };
    };
}