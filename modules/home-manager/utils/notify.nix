{ config, pkgs, ... }:

{
  
  home.packages = with pkgs; [
    libnotify
  ];
    
  services.dunst = {
    enable = true;
    # waylandDisplay = "WAYLAND_DISPLAY";
    settings = {
      global = {
        transparency = 10;
        origin = "top-right";
        font = "Terminus 10";
      };
      urgency_normal = {
        timeout = 0;
      };
    };
  };
  
  # home.file."dustrc".source = "${XDG_CONFIG_HOME}/dunst/dunstrc";

  programs.mako = {
    enable = false;
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
  
}
