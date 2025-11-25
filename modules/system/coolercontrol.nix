{ config, lib, pkgs, ... }:
let
  cfg = config.local.programs.coolercontrol;
in
{
  options.local.programs.coolercontrol = {
    enable = lib.mkEnableOption "Enable CoolerControl (Fan Control software)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (config.lib.nixGL.wrap coolercontrol.coolercontrol-gui)

      coolercontrol.coolercontrold
    ];
  };
}
