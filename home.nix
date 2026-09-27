{ config, pkgs, inputs, ... }:
let
  yaruVariant = "Yaru-blue-dark";

  openanime = inputs.openanime.packages.x86_64-linux.default.overrideAttrs (old: {
    yarnOfflineCache = pkgs.fetchYarnDeps {
      yarnLock = "${old.src}/yarn.lock";
      hash = "sha256-kUFtdnDKk4KIIobBSr0tOnm8zUrxGX/wXNsl++jr4Eo=";
    };
  });
in
{
  home.username = "bayram";
  home.homeDirectory = "/home/bayram";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    firefox
    discord
    telegram-desktop
    gedit
    spotify
    openanime
    fastfetch
    qbittorrent
    btop
    unzip
    onlyoffice-desktopeditors
    yaru-theme
    ubuntu-sans
  ];

  services.flatpak = {
    enable = true;
    remotes = [{ name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }];
    packages = [ 
      "org.vinegarhq.Sober" 
      "net.retrodeck.retrodeck"
      "io.itch.itch"
      ];
  };

  programs.git = {
    enable = true;
    settings.user.name = "tempestian";
    settings.user.email = "bayrambaglartr@gmail.com";
  };

  programs.kitty = {
    enable = true;
    settings.hide_window_decorations = "yes";
  };

  programs.bash = {
    enable = true;
    shellAliases = {

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

    "niri/config.kdl".source = ./niri/config.kdl;
  };

  home.file."local/bin/niri-sync-colors" = {
    source = ./scripts/niri-sync-colors;
    executable = true;
  };
  home.file."local/bin/record-screen" = {
    source = ./scripts/record-screen;
    executable = true;
  };

  systemd.user.services.niri-sync-colors = {
    Unit = {
      Description = "Wallpaper renklerine göre Niri focus-ring rengini canlı günceller";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "%h/.local/bin/niri-sync-colors --watch";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
