{ config, lib, pkgs, ... }:
with lib;
let
  
  latex = pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-basic
      wrapfig capt-of preview lxfonts latexmk
      natbib biblatex biblatex-abnt fourier xpatch
      ctex xetex minted fvextra amsmath upquote catchfile
      xstring framed dvipng hanging;
  };

  cfg = config.modules.office;
  
in {
  options = {
    modules.office = {
      enable = mkEnableOption "Enable office tools";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Academic
      # latex
      zotero
      
      # Sheets
      # libreoffice-bin

      # File-Management
      pcmanfm

      # Viewers
      poppler
      zathura

      # Chat
      pidgin
    ];
  };
}
