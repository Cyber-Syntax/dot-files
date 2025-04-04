{
  config,
  pkgs,
  unstable,
  lib,
  ...
}:
#NOTE: get unstable ollama
# final: prev:
# {
#   ollama = prev.ollama.overrideAttrs (old: {
#     src = prev.fetchFromGitHub {
#       owner = "ollama";
#       repo = "ollama";
#       rev = "master";
#       # If you don't know the hash, the first time, set:
#       # hash = "";
#       # then nix will fail the build with such an error message:
#       # hash mismatch in fixed-output derivation '/nix/store/m1ga09c0z1a6n7rj8ky3s31dpgalsn0n-source':
#       # specified: sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
#       # got:    sha256-173gxk0ymiw94glyjzjizp8bv8g72gwkjhacigd1an09jshdrjb4
#       hash = "sha256-ctz9xh1wisG0YUxglygKHIvU9bMgMLkGqDoknb8qSAU=";
#     };
#   });
# }
let
  customOverlay = self: super: {
    customOllama = super.ollama.overrideAttrs (oldAttrs: {
      version = "0.3.12"; # Ensure this matches the version you're trying to install
      src = super.fetchFromGitHub {
        owner = "ollama";
        repo = "ollama";
        rev = "v${oldAttrs.version}";
        hash = "sha256-K1FYXEP0bTZa8M+V4/SxI+Q+LWs2rsAMZ/ETJCaO7P8=";
      };
    });
  };
in {
  nixpkgs.overlays = [customOverlay];

  services = {
    ollama = {
      enable = true;
      acceleration = "cuda"; # enable nvidia cuda, or rocm
      package = pkgs.customOllama; # also use the package from the unstable channel!

      models = "/home/ollama/models";
      home = "/home/ollama";
      # group = "ollama";
      # user = "ollama";

      # openFirewall = true;

      environmentVariables = {
        OLLAMA_LLM_LIBRARY = "gpu";
        CUDA_VISIBLE_DEVICES = "0";
      };
    };
  };
  # override unstable ollama ProtectHome=true to empty string
  systemd.services.ollama.serviceConfig.ProtectHome = lib.mkForce "";
}
