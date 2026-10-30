{ inputs, vars, ... }:
{
  programs.tempest-shell = {
    enable = true;
    package = inputs.tempest-shell.packages.${vars.system}.default;
  };
}
