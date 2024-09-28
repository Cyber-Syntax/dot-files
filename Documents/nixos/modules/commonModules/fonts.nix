{pkgs, ...}:

{
  # font	
  fonts = {
    packages = with pkgs; [
      #corefonts # microsoft fonts
      #liberation_ttf
      dejavu_fonts
      #terminus_font
      #ubuntu_font_family
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      # # one of the nerd font
      # fira-code
      # fira-code-symbols
      # fira-code-nerdfont
      
      # example of overriding
      #(nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["DejaVu Sans Mono"];
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"]; 
      };
    };
  };

}
