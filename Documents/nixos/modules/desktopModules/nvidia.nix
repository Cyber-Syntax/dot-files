{ ... }:
#NOTE: propriety driver in use, modesettings enabled
#BUG: qtile can be cause issue with suspend
#TEST: if cause issue enable powerManagement and Fine-grained

{

      #TODO Learn later how to fix for ollama is not seeing the GPU ??
      #powerManagement.powerUpCommands = "rmmod nvidia_uvm && modprobe nvidia_uvm"; # This will executed after boot and resume from suspend but ollama still cause this issue because it's sometimes disable nvidia for saving power?
  services.xserver = {
    videoDrivers = [ 
        "nvidia"
        # Defaults
        #"modesetting"
        #"fbdev"
    ];

    #NOTE: solve screen tearing
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

  hardware.graphics.enable = true; 
  
  hardware.nvidia = {        
        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        #package = config.boot.kernelPackages.nvidiaPackages.stable;    # default probably production
        open = false; # nvidia-open for turing and above 
        
        #TODO enable these two for solve suspend issue if you see
        
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
        # stable: 545, production: 555 --- 30-05-24, 560.35 on 13-10-24
         
        #TODO debug, not work 
        #dynamicBoost.enable = true;
        
        #! modesetting: Cause the system to freeze on suspend for qtile -> 05.08.2024
        modesetting.enable = true;
      };
}

