{ pkgs, ... }:

let
  renpy-sdk = pkgs.buildFHSEnv {
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
    extraInstallCommands = ''
      mkdir -p $out/share/applications
      cat > $out/share/applications/renpy-sdk.desktop <<EOF
      [Desktop Entry]
      Type=Application
      Name=Ren'Py SDK
      Comment=Ren'Py Launcher
      Exec=$out/bin/renpy-sdk
      Icon=applications-games
      Terminal=false
      Categories=Development;Game;
      EOF
    '';
  };
in
{
  environment.systemPackages = [ renpy-sdk ];
  programs.nix-ld.enable = true;
}
