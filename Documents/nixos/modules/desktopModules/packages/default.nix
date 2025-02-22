{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    ntfs3g # windows

    android-tools # for phone like adb
    lsof # terminal command to see which processes use dir etc.
  ];
}
