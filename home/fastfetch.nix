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
          type = "command";
          key = "  󰃭 NixOS Age";
          shell = "/bin/sh";
          text = "echo $(( ($(date +%s) - $(stat -c %W /etc/machine-id)) / 86400 )) days";
          keyColor = "cyan";
        }
        {
          type = "wm";
          key = "  󱂬 WM";
          format = "{pretty-name}";
          keyColor = "blue";
        }
        {
          type = "shell";
          key = "  󰞷 Shell";
          format = "{exe-name}";
          keyColor = "cyan";
        }
        {
          type = "terminal";
          key = "   Terminal";
          format = "{exe-name}";
          keyColor = "blue";
        }
        {
          type = "cpu";
          key = "  󰍛 CPU";
          format = "{name}";
          keyColor = "cyan";
        }
        {
          type = "gpu";
          key = "  󰢮 GPU";
          hideType = "integrated";
          format = "{name}";
          keyColor = "blue";
        }
        {
          type = "memory";
          key = "  󰑭 Memory";
          format = "{used} / {total}";
          keyColor = "cyan";
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
