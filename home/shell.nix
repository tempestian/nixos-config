{
  programs.bash = {
    enable = true;
    shellAliases = {
      #update = "sudo nixos-rebuild switch --flake ~/nixos-config";
    };
  };
}
