{ config, lib, pkgs, ... }:
with lib;
let
	cfg = config.modules.alacritty;
in {
  options = {
    modules.alacritty = {
      enable = mkOption {
        type = types.bool;
        default = true;
      };
      font = {
        size = mkOption {
          type = types.int;
          default = 10;
        };
        name = mkOption {
          type = types.str;
          default = "";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = false;
      settings = {
        startup_mode = "Fullscreen";
        # background_opacity = 0.96;
        font = {
          size = cfg.font.size;
          normal.family = cfg.font.name;
          bold.family = cfg.font.name;
          italic.family = cfg.font.name;
        };
        cursor.style = {
          shape = "Block";
          blinking = "On";
        };
        window = {
          dimensions = {
            columns = 94; # 1366;
            lines = 22;   # 767;
          };
        };
        draw_bold_text_with_bright_colors = true;
        mouse.hide_when_typing = true;
      };
    };
    home.packages = with pkgs; [ kitty ];
  };
}

