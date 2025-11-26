{ config, lib, pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.zed-editor;
  };

  home.file.".config/zed/settings.json".source = ../../files/.config/zed/settings.json;
}
