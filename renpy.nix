{ pkgs, ... }:

let
  renpy-fhs = pkgs.buildFHSEnv {
    name = "renpy-sdk";
    targetPkgs = pkgs: with pkgs; [
      jdk21
      zlib
      ncurses5
      openssl
      freetype
      fontconfig
      libGL
      libGLU
      SDL2
      alsa-lib
      libpulseaudio
      glib
      gtk3
      xorg.libX11
      xorg.libXext
      xorg.libXrender
      xorg.libXi
      xorg.libXrandr
      xorg.libXcursor
      stdenv.cc.cc.lib
      which
      unzip
      curl
      bash
    ];
    profile = ''
      export JAVA_HOME=${pkgs.jdk21}/lib/openjdk
    '';
    runScript = pkgs.writeShellScript "renpy-run" ''
      exec "$HOME/renpy-sdk/renpy.sh" "$@"
    '';
  };

  renpy-desktop = pkgs.makeDesktopItem {
    name = "renpy-sdk";
    desktopName = "Ren'Py SDK";
    exec = "renpy-sdk";
    categories = [ "Development" "Game" ];
  };
in
{
  environment.systemPackages = [ renpy-fhs renpy-desktop ];

  programs.nix-ld.enable = true;
}
