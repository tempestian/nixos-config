{ vars, ... }:
{
  imports = [
    ./packages.nix
    ./shell.nix
    ./git.nix
    ./flatpak.nix
    ./gaming.nix
    ./display.nix
    ./gnome.nix
    ./theme
  ];

  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";
  home.stateVersion = vars.stateVersion;

  programs.home-manager.enable = true;
}
