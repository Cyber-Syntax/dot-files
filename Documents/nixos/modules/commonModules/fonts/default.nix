{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      font-awesome
      jetbrains-mono
      hack-font # current code editor font
      # example of overriding
      #(nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["JetBrains Mono"]; # Default: DejaVu Sans Mono
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
      };
    };
  };
}
