{ config, lib, pkgs, ... }:
let
  palette = import ./theme/palette.nix { inherit lib pkgs; };

  tempestCli = pkgs.runCommandLocal "tempest-shell-cli" { } ''
    mkdir -p $out/bin
    for f in ${config.programs.tempest-shell.package}/bin/*; do
      ln -s "$f" "$out/bin/$(basename "$f")"
    done
  '';
in
{
  programs.tempest-shell = {
    enable = true;
    preset = "tempest-capsule";
    mutableConfig = true;
    autostart = true;
    settings = {
      language = "tr";
      appearance = {
        theme = "material-you";
        wallpaper = "${palette.wallpaper}";
        fontFamily = "Inter, sans-serif";
      };
      cursor = {
        theme = "Bibata-Modern-Classic";
        size = 24;
        dynamicGlow = true;
      };
    };
  };

  home.packages = [
    tempestCli
    pkgs.libsForQt5.qtstyleplugin-kvantum
    pkgs.kdePackages.qtstyleplugin-kvantum
  ];
}
