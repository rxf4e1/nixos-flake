{ config, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      startup_mode = "Fullscreen";
      # background_opacity = 0.96;
      font = {
        size = 10.0;
        normal.family = "DejaVuSansMono Nerd Font Mono";
        bold.family = "DejaVuSansMono Nerd Font Mono";
        italic.family = "DejaVuSansMono Nerd Font Mono";
      };
      cursor.style = {
        shape = "Block";
        blinking = "On";
      };
      window = {
        dimensions = {
          columns = 94; # 1366;
          lines = 22;   #768;
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
