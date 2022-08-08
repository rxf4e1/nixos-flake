{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # blender
    feh
    ffmpeg-full
    font-manager
    gimp
    gimpPlugins.gmic
    imagemagickBig
    yt-dlp
    lutris
  ];

  programs = {
    mpv = {
      enable = true;
      config = {
        profile = "gpu-hq";
        vo = "gpu";
        hwdec = "auto-safe";
        ytdl-format = "ytdl-format=bestvideo[height<=?1920][fps<=?30][vcodec!=?vp9]+bestaudio/best";
      };
    };
  };
  
}
