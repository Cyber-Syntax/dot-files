{
  lib,
  pkgs,
  config,
  ...
}:
#FIX: tearing fix needed, wait this can be because of picom too
#TESTING: commenting some of new features
{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
      intel-compute-runtime
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  #TESTING: taring fix for intel
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };
  environment.variables = {
    VDPAU_DRIVER = lib.mkIf config.hardware.graphics.enable (lib.mkDefault "va_gl");
  };
  boot.initrd.kernelModules = ["i915"];

  environment.variables.LIBVA_DRIVER_NAME = "iHD";

  services.xserver = {
    videoDrivers = [
      "modesetting"
    ];
    #DRI: # default: set 2, other:3 which 3 solve tearing
    deviceSection = ''
      Driver "modesetting"
      Option "NoAccel" "True"
      Option "TearFree" "true"
      Option "DRI" "3"
    '';
  };
}
