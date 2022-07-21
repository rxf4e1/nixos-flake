{ config, pkgs, ... }:
  
{
  home.packages = with pkgs; [
    bat
    dash
    exa
    fd
    htop
    killall
    poppler
    ripgrep
    xcape
    unzip
    zip
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      changeDirWidgetCommand = "fd --color=auto --type=d";
      changeDirWidgetOptions = [ "--preview 'exa --tree --color=always -L 4 {}'" ];
      defaultCommand = "fd --color=auto";
      fileWidgetCommand = "fd --color=auto --type=f";
      fileWidgetOptions = [ "--preview 'head -n 100 {}'" ];
    };
  }; 
}
