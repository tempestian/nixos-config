{ vars, ... }:
{
  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };
}
