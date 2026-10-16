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
    gnome-text-editor
    spotify
    openanime
    fastfetch
    qbittorrent
    btop
    unzip
    onlyoffice-desktopeditors
    pear-desktop
  ];
}
