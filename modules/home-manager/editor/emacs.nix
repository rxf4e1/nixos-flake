{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    # use emacsPgtk for better integration with wayland.
    package = pkgs.emacsPgtk;
    extraPackages = epkgs: [
      epkgs.pdf-tools
    ];
  }; 
}
