{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.media;
in {
  options = {
    modules.media = {
      enable = mkOption {
        type = types.bool;
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      feh
      ffmpeg
      imagemagick
      yt-dlp
    ];

    programs = {
      mpv = {
        enable = true;
        config = {
          profile = "gpu-hq";
          vo = "gpu";
          hwdec = "auto-safe";
          ytdl-format = "ytdl-format=bestvideo[height<=?1366][fps<=?30][vcodec!=?vp9]+bestaudio/best";
        };
      };
    };
  };
}
