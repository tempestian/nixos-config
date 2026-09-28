{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    roboto-flex
    google-fonts
    twitter-color-emoji
    material-symbols
    corefonts
    inter
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Inter" "Noto Sans" ];
      serif = [ "Inter" "Noto Serif" ];
      monospace = [ "JetBrainsMono Nerd Font" ];
      emoji = [ "Twitter Color Emoji" ];
    };
  };
}
