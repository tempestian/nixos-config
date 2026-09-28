{ config, pkgs, inputs, lib, ... }:
let
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
    settings = {
      hide_window_decorations = "yes";
      background_opacity = "0.85";
      dynamic_background_opacity = "yes";
      shell = "fish";
    };
    extraConfig = ''
      include current-theme.conf
    '';
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
      celar = "printf '\\033[2J\\033[3J\\033[1;1H'";
      claer = "printf '\\033[2J\\033[3J\\033[1;1H'";
      ls = "eza --icons=auto";
      q = "inir run";
    };
    interactiveShellInit = ''
      set fish_greeting

      if command -v starship &>/dev/null
        starship init fish | source
      end
    '';
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

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    gtk-theme = "adw-gtk3-dark";
    icon-theme = "Yaru";
    cursor-theme = "Yaru";
    cursor-size = 24;
    font-name = "Inter Medium 11";
    monospace-font-name = "JetBrainsMono Nerd Font 11";
  };

  home.pointerCursor = {
    name = "Yaru";
    package = pkgs.yaru-theme;
    size = 24;
    x11.enable = true;
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Yaru";
    XCURSOR_SIZE = "24";
  };

  xdg.configFile = {
  };

  home.activation.niriConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.config/niri"
    rm -f "$HOME/.config/niri/config.kdl"
    install -m 644 ${./niri/config.kdl} "$HOME/.config/niri/config.kdl"
    ${pkgs.systemd}/bin/systemctl --user restart niri-sync-colors.service 2>/dev/null || true
  '';

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
