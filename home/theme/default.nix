{ config, lib, pkgs, ... }:
let
  palette = import ./palette.nix { inherit lib pkgs; };
  home = config.home.homeDirectory;

  cursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  gtkCss = ''
    @import url("colors.css");
  '';

  qtConf = qt: ''
    [Appearance]
    color_scheme_path=${home}/.config/${qt}/colors/matugen.conf
    custom_palette=true
    icon_theme=Papirus-Dark
    standard_dialogs=default
    style=Fusion

    [Fonts]
    fixed="JetBrainsMono Nerd Font,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
    general="Inter,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
  '';
in
{
  imports = [ ./matugen.nix ];

  assertions = [{
    assertion = builtins.hasAttr palette.accent palette.accents;
    message = "home/theme/accent geçersiz: '${palette.accent}'. Geçerli değerler: ${lib.concatStringsSep ", " (builtins.attrNames palette.accents)}";
  }];

  home.packages = with pkgs; [
    inter
    nerd-fonts.jetbrains-mono
    papirus-icon-theme
    adw-gtk3
  ];

  home.pointerCursor = {
    inherit (cursor) name package size;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "Inter";
      size = 11;
      package = pkgs.inter;
    };
    gtk3.extraCss = gtkCss;
    gtk4 = {
      theme = null;
      extraCss = gtkCss;
    };
  };

  xdg.configFile = {
    "qt5ct/qt5ct.conf".text = qtConf "qt5ct";
    "qt6ct/qt6ct.conf".text = qtConf "qt6ct";
  };

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    gtk-theme = "adw-gtk3-dark";
    icon-theme = "Papirus-Dark";
    cursor-theme = cursor.name;
    cursor-size = cursor.size;
    font-name = "Inter 11";
    monospace-font-name = "JetBrainsMono Nerd Font 11";
  };
}
