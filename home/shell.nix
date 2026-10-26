{ pkgs, ... }:
{
  programs.bash.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
    '';
    shellAbbrs = {
      update = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
      g = "git";
      gs = "git status";
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
}
