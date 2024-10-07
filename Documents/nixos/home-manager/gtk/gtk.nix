{ pkgs, ... }:

{
  home-manager.users.developer.gtk = {
    enable = true;

    theme = {
      name = "Materia-dark"; # Materia-light Materia-standard Materia-dark
      package = pkgs.materia-theme;
    };
    cursorTheme = {
      name = "Vimix-white-cursors";
      package = pkgs.vimix-cursors;
      size = 24;
    };
    font = {
      name = "Roboto";
      size = 13;
      package = pkgs.roboto;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.bookmarks = [
      "file:///home/developer/Documents"
      "file:///home/developer/Downloads"
      "file:///home/developer/Pictures/"
    ];
    gtk3.extraConfig = {
      #gtk-cursor-blink = false;
      #gtk-recent-files-limit = 20;
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      #gtk-cursor-blink = false;
      #gtk-recent-files-limit = 20;
      gtk-application-prefer-dark-theme = 1;
    };

  }; #./gtk

}
