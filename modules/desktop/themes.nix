{ config, lib, pkgs, ... }:
let
  cfg = config.local.desktop.themes;
in
{
  options.local.desktop.themes = {
    enable = lib.mkEnableOption "Enable loading of GTK themes";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [

    ];
  };
}
