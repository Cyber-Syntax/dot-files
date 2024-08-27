{ config, pkgs, lib,... }:


{
  home.file.qtile_config = {
    source = ./src;
    target = ".config/qtile";
    recursive = true;
  };
}
