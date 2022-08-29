{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.gtk;
in {
  options = {
    modules.gtk = {
      enable = mkOption {
        type = types.bool;
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      glib
      lxappearance-gtk2
      matcha-gtk-theme
      papirus-maia-icon-theme
      bibata-cursors-translucent
    ];

    # home.file.".gtkrc-2.0".source = ../../../config/gtkrc-2.0;
  };
}
