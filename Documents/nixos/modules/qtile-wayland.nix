{config, lib, pkgs, ... }:

# Qtile Wayland
# TODO: Nvidia driver is not good with wayland for now. I will try later.
{
  nixpkgs.overlays = [
  (self: super: {
    qtile-unwrapped = super.qtile-unwrapped.overrideAttrs(_: rec {
      postInstall = let
        qtileSession = ''
        [Desktop Entry]
        Name=Qtile Wayland
        Comment=Qtile on Wayland
        Exec=qtile start -b wayland
        Type=Application
        '';
        in
        ''
      mkdir -p $out/share/wayland-sessions
      echo "${qtileSession}" > $out/share/wayland-sessions/qtile.desktop
      '';
      passthru.providedSessions = [ "qtile" ];
    });
  })
];
# Sddm wayland:
services.displayManager = {
  sddm = {
    enable = true;
    defaultSession = "qtile";
      wayland = {
        enable = true;
        compositor = "weston"; # default: weston, alternative: kwin
      };
}
#/.sddm wayland: 

# Xserver wayland:
  services.xserver = {
    ## Basic settings
    #enable = true; # I think this is not needed on wayland
    xkb.layout = "tr";
    #./Basic settings
    
    ## Load nvidia driver for Xorg and wayland
    videoDrivers = [ "nvidia" ];
    #./Nvidia settings
    
    ## QTILE wayland
    windowManager.qtile = {
      enable = true;
      extraPackages = python3Packages: with python3Packages; [
        qtile-extras
      ];
    };
    #./qtile-wayland
    
    ## Qtile wayland session
    displayManager = {
      sessionPackages = [ pkgs.qtile-unwrapped ];
      wayland = {
        enable = true;
        defaultSession = "qtile";
      };
          
    };
    ## ./Qtile wayland session

  };
  #./xserver wayland:

# Other wayland settings:
  ## X11 programs:
  programs.xwayland.enable = true;

}
