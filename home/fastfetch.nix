{ config, pkgs, ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "${config.home.homeDirectory}/.config/fastfetch/rimuru.png";
        type = "kitty-direct";
        width = 26;
        height = 13;
        preserveAspectRatio = true;
        padding = {
          top = 0;
          left = 1;
          right = 2;
        };
      };
      display = {
        separator = " 󰄾 ";
        color = {
          keys = "cyan";
          title = "blue";
        };
      };
      modules = [
        {
          type = "title";
          format = "  {user-name-colored}  {host-name-colored}";
        }
        {
          type = "custom";
          format = "  ────────────────────────────";
        }
        {
          type = "os";
          key = "  󰣚 OS";
          format = "{name} {version-id}";
          keyColor = "blue";
        }
        {
          type = "kernel";
          key = "  󰌽 Kernel";
          format = "{release}";
          keyColor = "cyan";
        }
        {
          type = "uptime";
          key = "  󱫐 Uptime";
          format = "{hours}h {minutes}m";
          keyColor = "blue";
        }
        {
          type = "wm";
          key = "  󱂬 WM";
          format = "{pretty-name}";
          keyColor = "cyan";
        }
        {
          type = "shell";
          key = "  󰞷 Shell";
          format = "{exe-name}";
          keyColor = "blue";
        }
        {
          type = "terminal";
          key = "   Terminal";
          format = "{exe-name}";
          keyColor = "cyan";
        }
        {
          type = "cpu";
          key = "  󰍛 CPU";
          format = "{name}";
          keyColor = "blue";
        }
        {
          type = "gpu";
          key = "  󰢮 GPU";
          hideType = "integrated";
          format = "{name}";
          keyColor = "cyan";
        }
        {
          type = "memory";
          key = "  󰑭 Memory";
          format = "{used} / {total}";
          keyColor = "blue";
        }
        {
          type = "custom";
          format = "  ────────────────────────────";
        }
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
      ];
    };
  };

  xdg.configFile."fastfetch/rimuru.png".source = ./assets/rimuru.png;
}
