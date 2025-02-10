{
  config,
  pkgs,
  ...
}:

{
  #TESTING: wayland
  #FIX: modesetting not building for nvidia
  boot = {
    #NOTE: If you encounter the problem of booting to text mode you might try adding the Nvidia kernel module manually with:
    # initrd.kernelModules = [ "nvidia" ];
    # extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

    # Check: /etc/modules-load.d/nixos.conf
    extraModprobeConfig = ''
      options nvidia-drm modeset=1
    '';

    kernelParams = [
      "nvidia.NVreg_CheckPCIConfigSpace=0"
      "nvidia.NVreg_EnablePCIeGen3=1"
      "nvidia.NVreg_UsePageAttributeTable=1"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      "nvidia_drm.modeset=1"
    ];

    kernelModules = [
      #NOTE: seems like this is used for closed source driver?
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    #   extraModprobeConfig =
    #     "options nvidia "
    #     + lib.concatStringsSep " " [
    # nvidia assume that by default your CPU does not support PAT,
    # but this is effectively never the case in 2023
    #       "NVreg_UsePageAttributeTable=1"
    # This is sometimes needed for ddc/ci support, see
    # https://www.ddcutil.com/nvidia/
    #
    # Current monitor does not support it, but this is useful for
    # the future
    #       "NVreg_RegistryDwords=RMUseSwI2c=0x01;RMI2cSpeed=100"
    #   ];
  };

  #TODO: Learn later how to fix for ollama is not seeing the GPU ?
  #powerManagement.powerUpCommands = "rmmod nvidia_uvm && modprobe nvidia_uvm"; # This will executed after boot and resume from suspend but ollama still cause this issue because it's sometimes disable nvidia for saving power?

  services.xserver = {
    videoDrivers = [
      "nvidia"
      # Defaults
      #"modesetting"
      #"fbdev"
    ];

    # screenSection = ''
    #   Option         "metamodes" "2560x1440_144 +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
    #   Option         "SLI" "Off"
    #   Option         "MultiGPU" "Off"
    #   Option         "BaseMosaic" "off"
    #   SubSection     "Display"
    #       Depth       24
    #   EndSubSection
    # '';
  };

  #TODO: learn later
  # environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Optionally, set the environment variable

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    # # Vulkan
    # driSupport = true;

    #TESTING: new VA-API for nvidia. Setup:
    #TODO: https://github.com/elFarto/nvidia-vaapi-driver?tab=readme-ov-file#firefox
    extraPackages = with pkgs; [
      nvidia-vaapi-driver # A VA-API implementation using NVIDIA's NVDEC
      libvdpau-va-gl # VDPAU driver with OpenGL/VAAPI backend
      vaapiVdpau # VDPAU driver for the VA-API library
      #TESTING:
      libdrm # Direct Rendering Manager library and headers
      libglvnd # The GL Vendor-Neutral Dispatch library
      libva # An implementation for VA-API (Video Acceleration API)
      libva-utils # A collection of utilities and examples for VA-API
      libvdpau # Library to use the Video Decode and Presentation API for Unix (VDPAU)
      vdpauinfo # Tool to query VDPAU abilities of the system
    ];
  };

  environment.systemPackages = with pkgs; [
    #TESTING:
    egl-wayland
    libva-utils # A collection of utilities and examples for VA-API
    vdpauinfo # Tool to query VDPAU abilities of the system
  ];

  environment.variables = {
    # Required to run the correct GBM backend for nvidia GPUs on wayland
    GBM_BACKEND = "nvidia-drm";
    # Apparently, without this nouveau may attempt to be used instead
    # (despite it being blacklisted)
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    # Hardware cursors are currently broken on nvidia
    WLR_NO_HARDWARE_CURSORS = "1";

    #TESTING:
    # direct can be cause issue, change the egl if you encounter.
    # but seems like this is needed when used on nvidia-open?
    NVD_BACKEND = "direct"; # for nvidia-vaapi-driver.
    NVD_LOG = "1";

    #nixos_ozone already handle this
    # ELECTRON_OZONE_PLATFORM_HINT = "auto"; # for obsidian etc.

    #disable hardware Acceleration on electron base app which cause issue on obsidian?
    # Workaround, disable hardware Acceleration by their app settings
    # NOTE: solved on obsidian and don't see any problem on FreeTube now.
    # ELECTRON_DISABLE_HARDWARE_ACCELERATION = "1";

    #Default wayland variables
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_SCALE_FACTOR = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    WLR_DRM_DEVICES = "/dev/dri/card1"; # before = "/dev/dri/card1:/dev/dri/card0"
    CLUTTER_BACKEND = "wayland";
    # WLR_RENDERER = "vulkan"; # I don't play games
    __NV_PRIME_RENDER_OFFLOAD = "1";
    GTK_USE_PORTAL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";

  };

  hardware.nvidia = {
    # Production:550.135 and 6.12.6 24.11 for now.
    # Production: 565.77-6.12.4 saw that later
    # 04-01-25: Production: 550.135
    # 05-01-25 latest : 565.77 latest stable
    #BUG: 550.135 nvidia-open has suspend black screen issue.
    #NOTE: 565.77 still has issue but able to see cursor and black screen and quit qtile to see display-manager
    # but picom get %99 cpu usage after that, therefore it is still issue
    # package = config.boot.kernelPackages.nvidiaPackages.latest;

    #TESTING: wayland hyprland...
    # fix tearing
    forceFullCompositionPipeline = true;
    nvidiaSettings = false;

    open = true; # nvidia-open for turing and above

    # systemctl list-unit-files | grep nvidia
    # NVreg_PreserveVideoMemoryAllocations=1
    # enable nvidia-resume, nvidia-hibernation, nvidia-suspend services.
    powerManagement.enable = true;

    # (Turing and newer) Turns off GPU when not in use. ?? Need integrated gpu when offload nvidia???
    powerManagement.finegrained = false;

    #NOTE: nvidia option on xserver probably adding this by default because it's boot with nvidia-drm.modeset=1 on boot.
    modesetting.enable = true;
    # dynamicBoost.enable = true;

  };
  #TEST: fix 6.13 not build with 565.77
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "570.86.16"; # use new 570 drivers
    sha256_64bit = "sha256-RWPqS7ZUJH9JEAWlfHLGdqrNlavhaR1xMyzs8lJhy9U=";
    openSha256 = "sha256-DuVNA63+pJ8IB7Tw2gM4HbwlOh1bcDg2AN2mbEU9VPE=";
    settingsSha256 = "sha256-9rtqh64TyhDF5fFAYiWl3oDHzKJqyOW3abpcf2iNRT8=";
    usePersistenced = false;
  };
  # Specific nvidia version
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
