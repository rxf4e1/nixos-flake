{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.defaultPkgs.fonts;
  nerdFonts = pkgs.nerdfonts.override { fonts = [ "RobotoMono" ]; };
  
in
{
  # options.defaultPkgs.fonts = {
  #   enable = mkOption {
  #     type = types.bool;
  #     default = false;
  #     description = ''Enables user default fonts.'';
  #   };
  # };

  # config = mkIf cfg.enable {
  #   home.packages = with pkgs; [
  #     dejavu_fonts
  #     emacs-all-the-icons-fonts
  #     fira-code
  #     fira-code-symbols
  #     nerdFonts
  #     terminus_font
  #   ];
  # };
  
  fonts.fontconfig.enable = true;
  
}
