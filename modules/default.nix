{ config, pkgs, lib, ... }:

{
  imports =
    builtins.map (f: ./${f})
      (builtins.filter (
        n: lib.hasSuffix ".nix" n && n != "default.nix" && n != "inir-deps.nix"
      ) (builtins.attrNames (builtins.readDir ./.)));
}
