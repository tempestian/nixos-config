{ pkgs, ... }:
{
  home.packages = with pkgs.gnomeExtensions; [
    user-themes
    dash-to-dock
    blur-my-shell
    appindicator
    boost-volume
    caffeine
  ];

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

    "org/gnome/desktop/interface" = {
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

    "org/gnome/shell/extensions/blur-my-shell/overview".blur = true;
    "org/gnome/shell/extensions/blur-my-shell/appfolder".blur = true;
    "org/gnome/shell/extensions/blur-my-shell/popup".blur = true;
    "org/gnome/shell/extensions/blur-my-shell/lockscreen".blur = true;
    "org/gnome/shell/extensions/blur-my-shell/window-list".blur = true;
    "org/gnome/shell/extensions/blur-my-shell/coverflow-alt-tab".blur = true;

    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      blur = true;
      enable-all = false;
      dynamic-opacity = false;
      corner-when-maximized = false;
    };
  };
}
