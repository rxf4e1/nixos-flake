{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      startup_mode = "Fullscreen";
      # background_opacity = 0.96;
      font = {
        size = 8.5;
        normal.family = "Overpass Mono";
        bold.family = "Overpass Mono";
        italic.family = "Overpass Mono";
      };
      # font = {
      #   size = 9.0;
      #   normal.family = "RobotoMono Nerd Font Mono";
      #   bold.family = "RobotoMono Nerd Font Mono";
      #   italic.family = "RobotoMono Nerd Font Mono";
      # };
      cursor.style = {
        shape = "Block";
        blinking = "On";
      };
      window = {
        dimensions = {
          columns = 94; # 1366;
          lines = 22;   # 767;
        };
        # padding = {
        #   x = 0;
        #   y = 0;
        # };
        # decorations = "none";
      };
      draw_bold_text_with_bright_colors = true;
      mouse.hide_when_typing = true;
    }; # --- end settings
  };
}

