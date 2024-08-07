{ config, pkgs, lib,... }:


{
      ### GPU, NVIDIA, Proprietary Driver in use 
      hardware.nvidia = {
    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
        # Enable this if you have graphical corruption issues or 
        #application crashes after waking
        # up from sleep. This fixes it by saving the entire 
        # VRAM memory to /tmp/ instead 
        # of just the bare essentials
        powerManagement.enable = false;

        # Fine-grained power management. Turns off GPU when not in use.
        # Experimental and only works on modern Nvidia GPUs (Turing or newer).
        powerManagement.finegrained = false;
        nvidiaSettings = true;
         
        # Optionally, you may need to select the appropriate driver 
        # version for your specific GPU.
        package = config.boot.kernelPackages.nvidiaPackages.production; 
        # stable: 545, production: 555 --- 30-05-24
         
        # TODO: debug, not work
        #dynamicBoost.enable = true;
        open = false;
        #! modesetting: Cause the system to freeze on suspend -> 05.08.2024
        modesetting.enable = false;
      };
     
     hardware.graphics.enable = true; 

}

