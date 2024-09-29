{ lib, pkgs, ... }:

{
                                                                            ###### OLLAMA ####
    services = {
        ollama = {
            enable = true;
            acceleration = "cuda"; # enable nvidia cuda, or rocm
            package = pkgs.ollama; # also use the package from the unstable channel!
            
            models = "/home/ollama/models";
            home = "/home/ollama";
            group = "ollama";               
            user = "ollama";

            openFirewall = true;

            environmentVariables = {
              OLLAMA_LLM_LIBRARY = "gpu";
              CUDA_VISIBLE_DEVICES = "0";
            };
              
        };
    };
    # override unstable ollama ProtectHome=true to empty string
    systemd.services.ollama.serviceConfig.ProtectHome = lib.mkForce "";
                                                                              ###### ./OLLAMA ####
}


