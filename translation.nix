{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mkvtoolnix
    ffmpeg
    ffsubsync
    aegisub
    mpv
    whisper-cpp
    (python3.withPackages (ps: with ps; [ pysubs2 ]))
  ];
}
