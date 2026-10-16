{ vars, ... }:
{
  programs.git = {
    enable = true;
    settings.user = {
      name = vars.git.name;
      email = vars.git.email;
    };
  };
}
