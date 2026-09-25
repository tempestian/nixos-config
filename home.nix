{ config, pkgs, inputs, ... }:
let
  yaruVariant = "Yaru-blue-dark";
  yaruShellVariant =
    if pkgs.lib.hasSuffix "-dark" yaruVariant then "Yaru-dark" else "Yaru";
in
{
  home.username = "bayram";
  home.homeDirectory = "/home/bayram";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    firefox
    discord
    gedit
    spotify
    fastfetch
    qbittorrent
    btop
    unzip
    onlyoffice-desktopeditors
    yaru-theme
    gnomeExtensions.user-themes
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
    gnomeExtensions.appindicator
    gnomeExtensions.boost-volume
    gnomeExtensions.caffeine
    gnome-tweaks
    ubuntu-sans
  ];

  services.flatpak = {
    enable = true;
    remotes = [{ name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }];
    packages = [ 
      "org.vinegarhq.Sober" 
      "net.retrodeck.retrodeck"
      ];
  };

  systemd.services.flatpak-managed-install = {
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
  };

  programs.git = {
    enable = true;
    settings.user.name = "tempestian";
    settings.user.email = "bayrambaglartr@gmail.com";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      #update = "sudo nixos-rebuild switch --flake ~/nixos-config";

      theme-blue = "gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-blue-dark' && gsettings set org.gnome.shell.extensions.user-theme name 'Yaru-blue-dark'";
      theme-purple = "gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-purple-dark' && gsettings set org.gnome.shell.extensions.user-theme name 'Yaru-purple-dark'";
      theme-sage = "gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-sage-dark' && gsettings set org.gnome.shell.extensions.user-theme name 'Yaru-sage-dark'";
      theme-red = "gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-red-dark' && gsettings set org.gnome.shell.extensions.user-theme name 'Yaru-red-dark'";
      theme-orange = "gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-orange-dark' && gsettings set org.gnome.shell.extensions.user-theme name 'Yaru-orange-dark'";
      theme-light = "gsettings set org.gnome.desktop.interface gtk-theme 'Yaru' && gsettings set org.gnome.shell.extensions.user-theme name 'Yaru' && gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'";
    };
  };

  programs.home-manager.enable = true;

  services.nvibrant = {
    enable = true;
    vibrancy = [
      "160%"
    ];
  };


  programs.mangohud = {
    enable = true;
    settings = {
      position = "top-left";
      font_size = 24;
      background_alpha = 0.4;
      round_corners = 6;
      no_display = false;
      fps = true;
      cpu_stats = true;
      cpu_temp = true;
      gpu_stats = true;
      gpu_temp = true;
      frametime = false;
      frame_timing = false;
      ram = false;
      vram = false;
      engine_version = false;
      vulkan_driver = false;
      wine = false;
      toggle_hud = "Shift_R+F12";
    };
  };

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
    "gtk-4.0/gtk.css".source =
      "${pkgs.yaru-theme}/share/themes/${yaruVariant}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source =
      "${pkgs.yaru-theme}/share/themes/${yaruVariant}/gtk-4.0/gtk-dark.css";
    "gtk-4.0/assets".source =
      "${pkgs.yaru-theme}/share/themes/${yaruVariant}/gtk-4.0/assets";
  };

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "caffeine@patapon.info"
        "boostvolume@shaquib.dev"
        "blur-my-shell@aunetx"
      ];
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = yaruShellVariant;
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = yaruVariant;
      icon-theme = "Yaru";
      cursor-theme = "Yaru";
      cursor-size = 24;
      font-name = "Ubuntu 11";
      document-font-name = "Ubuntu 11";
      monospace-font-name = "Ubuntu Mono 13";
      show-battery-percentage = true;
      clock-show-weekday = true;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "LEFT";
      dash-max-icon-size = 48;
      transparency-mode = "FIXED";
      background-opacity = 0.8;
      autohide = false;
      intellihide = false;
      dock-fixed = true;
      extend-height = true;
      show-apps-at-top = true;
      click-action = "minimize";
      custom-theme-shrink = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
      titlebar-font = "Ubuntu Bold 11";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      natural-scroll = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-temperature = 3700;
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      hacks-level = 1;
      sigma = 30;
      brightness = 0.6;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = true;
      static-blur = true;
      unblur-in-overview = true;
      override-background-dynamically = false;
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      static-blur = true;
      pipeline = "pipeline_default";  
      corner-radius = 0;              
    };

    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      blur = true;
    };

    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      blur = true;
    };

    "org/gnome/shell/extensions/blur-my-shell/popup" = {
      blur = true; 
    };

    "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
      blur = true;
    };

    "org/gnome/shell/extensions/blur-my-shell/window-list" = {
      blur = true;
    };

    "org/gnome/shell/extensions/blur-my-shell/coverflow-alt-tab" = {
      blur = true;
    };

    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      blur = true;
      enable-all = false; 
      dynamic-opacity = false; 
      corner-when-maximized = false; 
    };
  };
}
