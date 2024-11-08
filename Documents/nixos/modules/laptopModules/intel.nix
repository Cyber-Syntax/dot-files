{ pkgs, ... }:

{

  hardware.graphics = {  
    enable = true;
   extraPackages = with pkgs; [
      intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
      #intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
      #TESTING:
      intel-ocl
      intel-vaapi-driver
   ];
  };
  #   xserver = {
  #     videoDrivers = [ "intel" ];
  # #TEST: tearing issue?
  #     deviceSection = ''
  #       Option "DRI" "2"
  #       Option "TearFree" "true"
  #     '';
  #
  #   };
  # };
services.xserver = {
    videoDrivers = [ # defaults below
        "modesetting"
        "fbdev"
    ];
        
     #Identifier  "Intel Graphics"
     #Driver      "intel"
     #Option "DRI" "False" # alternative if NoAccel not work
#NOTE: driver set itself intel???
     deviceSection = ''
        # Identifier  "Card0"
        # Driver      "modesetting"
        # BusID       "PCI:0:2:0"
         Driver "modesetting"
         Option "NoAccel" "True"
        Option "TearFree" "true"
        Option "DRI" "3" # default: set 2
     '';
# already handle itself
     # monitorSection = ''
     #    Identifier "Monitor[0]"
     # '';
  };
}
