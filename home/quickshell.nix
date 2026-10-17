{ lib, pkgs, ... }:
let
  palette = import ./theme/palette.nix { inherit lib pkgs; };
in
{
  programs.qs-niri = {
    enable = true;
    profile = "bloated";
    settings = {
      appearance.fontFamily = "Inter";
      theme = {
        mode = "dark";
        scheme = "scheme-tonal-spot";
        image = "${palette.wallpaper}";
      };
      paths.screenshotsDir = "~/Pictures/Screenshots";
      launcher = {
        terminalCommand = [ "kitty" ];
        favorites = [ "firefox" "kitty" "thunar" "discord" "spotify" "steam" ];
      };
      gaming.appIds = [ "^heroic" "^prismlauncher" "^org\\.prismlauncher" "^eden" ];
      lock.idleMinutes = 15;
    };
  };
}
