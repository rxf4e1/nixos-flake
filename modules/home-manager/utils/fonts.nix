{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.modules.fonts;
  nerdFonts = pkgs.nerdfonts.override { fonts = [ "RobotoMono" ]; };
  
in
{
  options.modules.fonts = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''Enables user default fonts.'';
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dejavu_fonts
      emacs-all-the-icons-fonts
      fira-code
      fira-code-symbols
      meslo-lgs-nf
      # nerdFonts
      terminus_font
      font-manager
    ];
    
    fonts.fontconfig.enable = true;
  };
}
