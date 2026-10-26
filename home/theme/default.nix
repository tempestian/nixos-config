{ lib, pkgs, ... }:
let
  accents = [ "blue" "purple" "sage" "red" "orange" ];
  accent = lib.strings.trim (builtins.readFile ./accent);
  dark = true;

  yaruVariant = "Yaru-${accent}" + lib.optionalString dark "-dark";
  yaruShellVariant = if dark then "Yaru-dark" else "Yaru";
  themeDir = "${pkgs.yaru-theme}/share/themes/${yaruVariant}/gtk-4.0";
in
{
  assertions = [{
    assertion = builtins.elem accent accents;
    message = "home/theme/accent geçersiz: '${accent}'. Geçerli değerler: ${lib.concatStringsSep ", " accents}";
  }];

  home.packages = with pkgs; [
    yaru-theme
    ubuntu-sans
  ];

  gtk = {
    enable = true;
    theme = {
      name = yaruVariant;
      package = pkgs.yaru-theme;
    };
    iconTheme = {
      name = "Yaru";
      package = pkgs.yaru-theme;
    };
    cursorTheme = {
      name = "Yaru";
      package = pkgs.yaru-theme;
      size = 24;
    };
  };

  xdg.configFile = {
    "gtk-4.0/gtk.css".source = "${themeDir}/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${themeDir}/gtk-dark.css";
    "gtk-4.0/assets".source = "${themeDir}/assets";
  };

  dconf.settings = {

    "org/gnome/desktop/interface" = {
      color-scheme = if dark then "prefer-dark" else "prefer-light";
      gtk-theme = yaruVariant;
      icon-theme = "Yaru";
      cursor-theme = "Yaru";
      cursor-size = 24;
      font-name = "Ubuntu 11";
      document-font-name = "Ubuntu 11";
      monospace-font-name = "Ubuntu Mono 13";
    };
  };
}
