{
  lib,
  pkgs-unstable,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    python312Packages.litellm
    python312Packages.tokenizers
    libstdcxx5 # for litellm
  ];

  services = {
    # To enable repo look-ups and downloads online, pass 'local_files_only=False' as input.
    # chat UI for ollama models
    open-webui = {
      enable = true;
      # stateDir = "/home/developer/openwebui/";
      package = pkgs-unstable.open-webui;
      port = 4242; # default: port 8080
      host = "0.0.0.0"; # default: host "127.0.0.1"
      openFirewall = true;
      # prevent the secrets read on nix store:
      # environmentFile = "/home/developer/openwebui/openWebuiSecrets/secret_key";
      environment = {
        # DATA_DIR = "/data/open-webui";
        ANONYMIZED_TELEMETRY = "False";
        DO_NOT_TRACK = "True";
        SCARF_NO_ANALYTICS = "True";
        WEBUI_AUTH = "False";
        OLLAMA_BASE_URL = "http://localhost:11434";
        # WEBUI_SECRET_KEY = "/home/developer/openwebui/openWebuiSecrets/secret_key";
      };
    };

    ollama = {
      # port 11434
      # host "127.0.0.1"
      enable = true;
      acceleration = "cuda"; # enable nvidia cuda, or rocm
      package = pkgs-unstable.ollama;

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
}
