{ config, lib, pkgs, inputs, vars, ... }:
let
  palette = import ./theme/palette.nix { inherit lib pkgs; };

  patchedTempestShell = inputs.tempest-shell.packages.${vars.system}.default.overrideAttrs (old: {
    buildCommand = (old.buildCommand or "") + ''
      awk '!seen[$0]++ || !/readonly property string scannerPath/'         $out/services/Applications.qml > $out/services/Applications.qml.tmp
      mv $out/services/Applications.qml.tmp $out/services/Applications.qml
    '';
  });

  tempestCli = pkgs.runCommandLocal "tempest-shell-cli" { } ''
    mkdir -p $out/bin
    for f in ${patchedTempestShell}/bin/*; do
      ln -s "$f" "$out/bin/$(basename "$f")"
    done
  '';
in
{
  programs.tempest-shell = {
    enable = true;
    package = patchedTempestShell;
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
