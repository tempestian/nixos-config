{ lib, pkgs }:
let
  accents = {
    blue = "#89b4fa";
    purple = "#cba6f7";
    sage = "#a6e3a1";
    red = "#f38ba8";
    orange = "#fab387";
  };

  accent = lib.strings.trim (builtins.readFile ./accent);
  accentHex = accents.${accent} or accents.blue;

  wallpaper = pkgs.runCommand "wallpaper.png" { nativeBuildInputs = [ pkgs.imagemagick ]; } ''
    magick -size 3840x2160 radial-gradient:'${accentHex}'-'#11111b' -modulate 70,100 png:$out
  '';
in
{
  inherit accents accent accentHex wallpaper;

  base = {
    bg = "#1e1e2e";
    mantle = "#181825";
    crust = "#11111b";
    surface = "#313244";
    overlay = "#7f849c";
    text = "#cdd6f4";
    subtext = "#bac2de";
    red = "#f38ba8";
    green = "#a6e3a1";
    yellow = "#f9e2af";
    blue = "#89b4fa";
    pink = "#f5c2e7";
    teal = "#94e2d5";
  };
}
