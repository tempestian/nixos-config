{ pkgs, vars, ... }:
{
  users.users.${vars.username} = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };
}
