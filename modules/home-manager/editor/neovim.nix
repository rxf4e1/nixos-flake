{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    nodejs
    yarn
    yarn2nix
    # nodePackages.npm
    ninja
  ];
}
