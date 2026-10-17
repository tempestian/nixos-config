{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      #update = "sudo nixos-rebuild switch --flake ~/nixos-config";
    };
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -g fish_greeting
      if test -f $HOME/.config/fish/matugen.fish
        source $HOME/.config/fish/matugen.fish
      end
    '';

    shellAliases = {
      ls = "eza --icons --group-directories-first";
      ll = "eza -l --icons --group-directories-first";
      la = "eza -la --icons --group-directories-first";
      cat = "bat --paging=never";
    };

    shellAbbrs = {
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
      directory.truncation_length = 3;
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza.enable = true;
  programs.bat.enable = true;

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "matugen";
      theme_background = false;
    };
  };
}
