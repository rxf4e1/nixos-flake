{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.clitools;
in {
  options = {
    modules.clitools = {
      enable = mkOption {
        type = types.bool;
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bat
      dash
      exa
      fd
      htop
      killall
      procs
      ripgrep
      xcape
      weechat
    ];

    xdg = {
      enable = true;
      # cacheHome = "$HOME/.cache";
      # configHome = "$HOME/.config";
      # dataHome = "$HOME/.local/share";
      userDirs = {
        enable = true;
        createDirectories = true;
        desktop = "$HOME/Desktop";
        documents = "$HOME/Documents";
        download = "$HOME/Downloads";
        pictures = "$HOME/Pictures";
        publicShare = "$HOME/Public";
        templates = "$HOME/Templates";
      };
      mime.enable = true;
      mimeApps = {
        enable = true;
        associations = {
          added = {
            "application/pdf" = ["org.pwmt.zathura.desktop"];
          };
          removed = {
            "application/pdf" = ["brave-browser.desktop"];
          };
        };
        defaultApplications = {
          "application/pdf" = ["org.pwmt.zathura.desktop"];
        };
      };
    };

    programs = {
      direnv = {
        enable = true;
        nix-direnv = {
          enable = true;
        };
      };

      fzf = {
        enable = true;
        enableZshIntegration = true;
        changeDirWidgetCommand = "fd --color=auto --type=d";
        changeDirWidgetOptions = [ "--preview 'exa --tree --color=always -L 4 {}'" ];
        defaultCommand = "fd --color=auto";
        fileWidgetCommand = "fd --color=auto --type=f";
        fileWidgetOptions = [ "--preview 'head -n 100 {}'" ];
      };
    }; 
  };
}
