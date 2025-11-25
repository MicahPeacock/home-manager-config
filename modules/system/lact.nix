{ config, lib, pkgs, ... }:
let
  cfg = config.local.programs.lact;
in
{
  options.local.programs.lact = {
    enable = lib.mkEnableOption "Enable LACT (AMD GPU overclocking/undervolting software)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (config.lib.nixGL.wrap lact)
    ];
  };
}
