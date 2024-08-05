{ config, pkgs, lib, ... }:

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
#


# { config, pkgs, lib, ... }:
#
#
# let
#   pname = "ollama";
#   # don't forget to invalidate all hashes each update
#   version = "0.3.1";
#
#   src = pkgs.fetchFromGitHub {
#     owner = "ollama";
#     repo = "ollama";
#     rev = "v${version}";
#     hash = "sha256-iD7LX4OstnNL2FZKObh4z9krkN0sfUUbFEZxu6OvdBs=";
#     fetchSubmodules = true;
#   };
#
#   vendorHash = "sha256-hSxcREAujhvzHVNwnRTfhi0MKI3s8HNavER2VLz6SYk=";
#
#
# # let
# #   ollamaSrc = pkgs.fetchFromGitHub {
# #     owner = "ollama";
# #     repo = "ollama";
# #     rev = "master"; # Fetch the latest master
# #     sha256 = "sha256-EI3dQcsvv8T4lYNcWML8SesOQfAkCEsZvd+C3S+MY5o=";
# #   };
# #
# #   customOllama = pkgs.buildGoModule {
# #     pname = "ollama";
# #     version = "0.3.2"; # Update this to the correct version
# #     src = ollamaSrc;
# #   };
# #
# in {
#   services.ollama = {
#     enable = true;
#     acceleration = "cuda"; # enable nvidia cuda, or rocm
#     package = pkgs.ollama;
#     models = "/home/ollama/models";
#     home = "/home/ollama";
#     group = "ollama";               
#     user = "ollama";
#     openFirewall = true;
#     environmentVariables = {
#       OLLAMA_LLM_LIBRARY = "gpu";
#       CUDA_VISIBLE_DEVICES = "0";
#     };
#   };
#
#   # Override unstable ollama ProtectHome=true to empty string
#   systemd.services.ollama.serviceConfig.ProtectHome = lib.mkForce "";
# }



# { config, pkgs, lib,... }:
#
# let
#   customOverlay = self: super: {
#     customOllama = super.ollama.overrideAttrs (oldAttrs: {
#       version = "0.3.1";  # Ensure this matches the version you're trying to install
#       src = super.fetchFromGitHub {
#         owner = "ollama";
#         repo = "ollama";
#         rev = "v${oldAttrs.version}";
#         hash = "sha256-ctz9xh1wisG0YUxglygKHIvU9bMgMLkGqDoknb8qSAU=";
#       };
#     });
#   };
# in
# {
#
#   nixpkgs.overlays = [ customOverlay ];
#
#   services = {
#       ollama = {
#           enable = true;
#           acceleration = "cuda"; # enable nvidia cuda, or rocm
#           package = pkgs.customOllama; # also use the package from the unstable channel!
#           
#           models = "/home/ollama/models";
#           home = "/home/ollama";
#           group = "ollama";               
#           user = "ollama";
#
#           openFirewall = true;
#
#           environmentVariables = {
#             OLLAMA_LLM_LIBRARY = "gpu";
#             CUDA_VISIBLE_DEVICES = "0";
#           };
#             
#       };
#   };
#   # override unstable ollama ProtectHome=true to empty string
#   systemd.services.ollama.serviceConfig.ProtectHome = lib.mkForce ""; 
# }
#
