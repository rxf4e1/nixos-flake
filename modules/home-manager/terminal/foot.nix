{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    package = pkgs.foot;
    server.enable = true;
    settings = {
      main = {
        term = "screen-256color";
        
        font = "RobotoMono Nerd Font Mono:size=9";
        dpi-aware = "yes";
      };

      scrollback = {
        lines = 1000;
      };

      cursor = {
        color = "141a1b eeeeee";
      };
      
      mouse = {
        hide-when-typing = "yes";
      };

      colors = {
        alpha = 0.9;
        foreground = "eeeeee";
        background = "141a1b";
        regular0 = "141a1b";
        regular1 = "cd3f45";
        regular2 = "9fca56";
        regular3 = "e6cd69";
        regular4 = "16a085";
        regular5 = "a074c4";
        regular6 = "55b5db";
        regular7 = "d6d6d6";
        bright0 = "41535B";
        bright1 = "cd3f45";
        bright2 = "9fca56";
        bright3 = "e6cd69";
        bright4 = "16a085";
        bright5 = "a074c4";
        bright6 = "55b5db";
        bright7 = "ffffff";
      };
    };
  };
  
}
