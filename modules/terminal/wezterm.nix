{ config, lib, pkgs, ... }:
let
  cfg = config.local.programs.wezterm;
  shared = config.local.programs.terminal;
in
{
  options.local.programs.wezterm = {
    enable = lib.mkEnableOption "Enable WezTerm, a GPU-accelerated cross-platform terminal emulator and multiplexer";
    theme = lib.mkOption {
      type = lib.types.str;
      default = shared.theme;
      description = "Color scheme to use in WezTerm";
    };
    opacity = lib.mkOption {
      type = lib.types.float;
      default = shared.opacity;
      description = "Window opacity to use in WezTerm";
    };
    font = {
      name = lib.mkOption {
        type = lib.types.str;
        default = shared.font.name;
        description = "Font family to use in WezTerm";
      };
      size = lib.mkOption {
        type = lib.types.int;
        default = shared.font.size;
        description = "Font size (in px) to use in WezTerm";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.wezterm;
      enableBashIntegration = true;
      enableZshIntegration  = true;
    };

    home.file = {
      ".config/wezterm/wezterm.lua".source     = ../../files/.config/wezterm/wezterm.lua;
      ".config/wezterm/keybindings.lua".source = ../../files/.config/wezterm/keybindings.lua;
      ".config/wezterm/options.lua".text = ''
        return {
          shell = {'${config.home.homeDirectory}/.nix-profile/bin/${config.local.programs.shell.default}' },
          theme = '${cfg.theme}',
          opacity = ${builtins.toString cfg.opacity},
          font_name = '${cfg.font.name}',
          font_size = ${builtins.toString cfg.font.size},
        }
      '';
    };
  };
}
