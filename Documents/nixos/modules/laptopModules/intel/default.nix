{
  lib,
  pkgs,
  config,
  ...
}:
#FIX: tearing fix needed, wait this can be because of picom too
#TESTING: commenting some of new features
{
  # TODO: setup hardware for laptop
  # set this if tlp not able to handle it
  #NOTE: if max freq is is 400mhz on battery disable Intel SpeedStep in the BIOS
  # seems like tlp already handle this to powersave and ondemand is not work anymore on linux
  # powerManagement.cpuFreqGovernor = ""; # ondemand, performance, powersave
  #NOTE: THIS IS NOT WORKING on i5-13th gen yet
  #NOTE: https://github.com/erpalma/throttled/issues?q=13th
  #TEST: some of the user tested and used but have issue with tlp.

  #BUG: i5-1335U not supported yet.
  # throttled.enable = true; # fix for intel cpu throttling on thinkpads

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
