{ pkgs, inputs, vars, ... }:
let
  openanime = inputs.openanime.packages.${vars.system}.default.overrideAttrs (old: {
    yarnOfflineCache = pkgs.fetchYarnDeps {
      yarnLock = "${old.src}/yarn.lock";
      hash = "sha256-kUFtdnDKk4KIIobBSr0tOnm8zUrxGX/wXNsl++jr4Eo=";
    };
  });
in
{
  home.packages = with pkgs; [
    firefox
    discord
    telegram-desktop
    mousepad
    spotify
    openanime
    fastfetch
    qbittorrent
    unzip
    onlyoffice-desktopeditors
    antigravity-ide-fhs
    github-mcp-server
    pear-desktop
    mpv
    imv
    xarchiver
    pavucontrol
    networkmanagerapplet
    qalculate-gtk
    wl-clipboard
    pv
    rsync
    kotlin
    gradle
    jdk17
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };
}
