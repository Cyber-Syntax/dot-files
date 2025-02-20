{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      #ubuntu_font_family
      noto-fonts-cjk-sans
      noto-fonts-emoji
      font-awesome
      # fira-code
      # fira-code-symbols
      # fira-code-nerdfont
      # example of overriding
      #(nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "DejaVu Sans Mono" ];
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
      };
    };
  };
}
