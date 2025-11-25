{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules/desktop
    ../modules/shell
    ../modules/terminal
  ];

  local = {
    desktop.fonts.enable = lib.mkDefault true;

    programs.shell.default  = lib.mkDefault "bash";
    programs.wezterm.enable = lib.mkDefault true;
  };

  fonts.fontconfig.enable = lib.mkIf config.local.desktop.fonts.enable true;
}
