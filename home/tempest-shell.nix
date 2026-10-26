{ pkgs, ... }:
{
  programs.tempest-shell = {
    enable = true;
    preset = "tempest-capsule"; # "tempest-capsule" veya "mactempest"
    mutableConfig = true;
    # Yerel geliştirme için out-of-store symlink kullanmak isterseniz:
    # configSymlink = "/home/bayram/Projeler/tempest-shell";
  };
}
