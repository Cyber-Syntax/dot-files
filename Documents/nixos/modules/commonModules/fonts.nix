{pkgs, ...}:

{
  # font	
  fonts = {
    packages = with pkgs; [
      #corefonts # microsoft fonts
      liberation_ttf
      dejavu_fonts
      terminus_font
      ubuntu_font_family
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Jetbrains Mono Bold"];
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"]; 
      };
    };
  };

}
