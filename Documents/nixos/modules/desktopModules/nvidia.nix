{ ... }:
# Nvidia-open is used now.
# TODO: Use proprietary drivers later

{

      # Fix for ollama is not seeing the GPU 
      #powerManagement.powerUpCommands = "rmmod nvidia_uvm && modprobe nvidia_uvm"; # This will executed after boot and resume from suspend.
      # it's work nvidia-open for now
  services.xserver.videoDrivers = [ 
    "nvidia"
    # Defaults
    #"modesetting"
    #"fbdev"
  ];

  hardware.graphics.enable = true; 
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
        
        # # if finegrained is enabled
        #   prime.offload.enable = true;
        #   # if offload enabled
        #     prime.nvidiaBusId = "00000000:2B:00.0";

        nvidiaSettings = true;
         
        # Optionally, you may need to select the appropriate driver 
        # version for your specific GPU.
        #package = config.boot.kernelPackages.nvidiaPackages.production; 
        # stable: 545, production: 555 --- 30-05-24
         
        # TODO: debug, not work
        #dynamicBoost.enable = true;
        
        # open is useable with my rtx2060
        open = true;
        #! modesetting: Cause the system to freeze on suspend for qtile -> 05.08.2024
        modesetting.enable = false;
      };

}

