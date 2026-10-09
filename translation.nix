{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mkvtoolnix
    ffmpeg

    ffsubsync
    alass

    aegisub
    subtitleedit
    mpv

    whisper-cpp

    (python3.withPackages (ps: with ps; [ pysubs2 ]))
  ];
}
