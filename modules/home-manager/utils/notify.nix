{ config, lib, pkgs, ... }:
with lib;
let
	cfg = config.modules.notify;
in {

  options = {
    modules.notify = {
      enable = mkOption {
        type = types.bool;
        default = true;
      };
      withWayland = {
        enable = mkEnableOption "Enable when wayland" // {
          default = true;
        };
        display = mkOption {
          type = types.str;
          default = "WAYLAND_DISPLAY";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libnotify
    ];
      
    services.dunst = {
      enable = true;
      waylandDisplay = cfg.withWayland.display;
      settings = {
        global = {
          transparency = 10;
          origin = "top-right";
          font = "Terminus 10";
        };
        urgency_normal = {
          timeout = 20;
        };
      };
    };
    
    # home.file."dustrc".source = "${XDG_CONFIG_HOME}/dunst/dunstrc";

    programs.mako = {
      enable = cfg.withWayland.enable;
      package = pkgs.mako;
      actions = true;
      anchor = "bottom-right";
      backgroundColor = "#141a1b";
      borderColor = "#16a085";
      borderRadius = 5;
      borderSize = 2;
      defaultTimeout = 0;
      font = "Terminus 10";
      # format = "";
      # groupBy = "";
      # height = 200;
      # width = 300;
      icons = true;
      # layer = "overlay";
      textColor = "#FFFFFF";
      # extraConfig = '' '';
    };
    # home.file."makorc".source = "${XDG_CONFIG_HOME}/mako/config";
  };
}
