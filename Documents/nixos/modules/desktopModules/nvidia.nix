{ config, pkgs, lib, unstable, ... }:
#TEST: normal stable nvidia, stable linux kernel

#TODO: handle nvidia version via unstable pkgs instead specific

#BUG: display manager not start after open, propriety 560.34 or even all other extras commented.
# try to use manually module adding but not worked either.

{

# boot = {
#     #NOTE: If you encounter the problem of booting to text mode you might try adding the Nvidia kernel module manually with: 
#       initrd.kernelModules = [ "nvidia" ];
#       extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

#
#     #NOTE: "nvidia-drm.modeset=1" add this if modeset not enabled 
#     # it probably need to be added because nvidia.modesetting true option.
#     # Check: /etc/modules-load.d/nixos.conf
#
#    kernelParams = [ "nvidia_drm.fbdev=1" ];
# #TESTING: testing latest linux version from nixpkgs-unstable: 6.11.4
#  #   kernelPackages = unstable.linuxPackages_latest;
#
#
#  #   extraModprobeConfig =
#  #     "options nvidia "
#  #     + lib.concatStringsSep " " [
#         # nvidia assume that by default your CPU does not support PAT,
#         # but this is effectively never the case in 2023
#  #       "NVreg_UsePageAttributeTable=1"
#         # This is sometimes needed for ddc/ci support, see
#         # https://www.ddcutil.com/nvidia/
#         #
#         # Current monitor does not support it, but this is useful for
#         # the future
#  #       "NVreg_RegistryDwords=RMUseSwI2c=0x01;RMI2cSpeed=100"
#  #   ];
#   };

#TODO Learn later how to fix for ollama is not seeing the GPU ??
#powerManagement.powerUpCommands = "rmmod nvidia_uvm && modprobe nvidia_uvm"; # This will executed after boot and resume from suspend but ollama still cause this issue because it's sometimes disable nvidia for saving power?

  services.xserver = {
    videoDrivers = [ 
        "nvidia"
        # Defaults
        #"modesetting"
        #"fbdev"
    ];

     #NOTE: I find a setting for that on hardware.nvidia
     screenSection = ''
         Option         "metamodes" "2560x1440_144 +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
         Option         "SLI" "Off"
         Option         "MultiGPU" "Off"
         Option         "BaseMosaic" "off"
         SubSection     "Display"
             Depth       24
         EndSubSection
     '';
  };

# #TEST: picom solve tearing?? X11
#   services.picom = {
#     enable = true;
#     inactiveOpacity = 0.8;
#     settings = {
#       "unredir-if-possible" = true;
#       "focus-exclude" = "name = 'slock'";
#     };
#   };

#NOTE: only 24.05
  hardware.opengl = { # hardware.opengl in 24.05 and older 
    enable = true;
#    extraPackages = with pkgs; [
#TODO: add to laptop
      # intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
      # intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
#      nvidia-vaapi-driver
#      libvdpau-va-gl
#    ];
  };

#TODO: learn later
# environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Optionally, set the environment variable

#TODO: add this on version 24.11
#   hardware.graphics = {
#       enable = true;
# # #TESTING: new VA-API for nvidia. Setup:
# # #TODO: https://github.com/elFarto/nvidia-vaapi-driver?tab=readme-ov-file#firefox
# #       extraPackages = with pkgs; [
# #         nvidia-vaapi-driver
# #         libvdpau-va-gl 
# #       ];
#   };

#   environment.variables = {
#     # Required to run the correct GBM backend for nvidia GPUs on wayland
# #    GBM_BACKEND = "nvidia-drm";
#     # Apparently, without this nouveau may attempt to be used instead
#     # (despite it being blacklisted)
# #    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
#     # Hardware cursors are currently broken on nvidia
# #    WLR_NO_HARDWARE_CURSORS = "1";
#   };
  
  hardware.nvidia = {
    #  forceFullCompositionPipeline = true; # Fix tearing
      open = false; # nvidia-open for turing and above 
      powerManagement.enable = false;
      powerManagement.finegrained = false; #(Turing and newer) Turns off GPU when not in use. Need integrated gpu when offload nvidia
      nvidiaSettings = true;   
      modesetting.enable = false;
      #dynamicBoost.enable = true;
      };

#   hardware.nvidia.package = 
# #    let
#     #Fixes framebuffer with linux 6.11 
# #      fbdev_linux_611_patch = pkgs.fetchpatch {
# #        url = "https://patch-diff.githubusercontent.com/raw/NVIDIA/open-gpu-kernel-modules/pull/692.patch";
# #        hash = "sha256-OYw8TsHDpBE5DBzdZCBT45+AiznzO9SfECz5/uXN5Uc=";
# #      };
# #    in
#     config.boot.kernelPackages.nvidiaPackages.mkDriver {
#       version = "560.35.03";
#       sha256_64bit = "sha256-8pMskvrdQ8WyNBvkU/xPc/CtcYXCa7ekP73oGuKfH+M=";
#       sha256_aarch64 = "sha256-s8ZAVKvRNXpjxRYqM3E5oss5FdqW+tv1qQC2pDjfG+s=";
#       openSha256 = "sha256-/32Zf0dKrofTmPZ3Ratw4vDM7B+OgpC4p7s+RHUjCrg=";
#       settingsSha256 = "sha256-kQsvDgnxis9ANFmwIwB7HX5MkIAcpEEAHc8IBOLdXvk=";
#       persistencedSha256 = "sha256-E2J2wYYyRu7Kc3MMZz/8ZIemcZg68rkzvqEwFAL3fFs=";
# #      patchesOpen = [ fbdev_linux_611_patch ];
#   };

}

