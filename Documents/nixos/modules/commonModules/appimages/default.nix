{ pkgs, ... }:
{
  # ### Appimage won't work without it, appimage-run
  # boot.binfmt.registrations.appimage = {
  #   wrapInterpreterInShell = false;
  #   interpreter = "${pkgs.appimage-run}/bin/appimage-run";
  #   recognitionType = "magic";
  #   offset = 0;
  #   mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
  #   magicOrExtension = ''\x7fELF....AI\x02'';
  # };

  # the binfmt_misc registration described above can now be applied in a straightforward way by just setting below:
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
