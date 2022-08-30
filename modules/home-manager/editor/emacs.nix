{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.emacs;
in {
  options = {
    modules.emacs = {
      enable = mkOption {
        type = types.bool;
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      # use emacsPgtk for better integration with wayland.
      package = pkgs.emacsPgtk;
      # extraPackages = epkgs: [
      #   epkgs.pdf-tools
      # ];
    };
    # services.emacs = {
    #   enable = true;
    # };
  };
}
