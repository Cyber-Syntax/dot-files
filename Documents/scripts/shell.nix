{ pkgs ? import <nixpkgs> {} }:
let
  bp = pkgs.callPackage .../nix-npm-buildpackage {};
in 
 bp.buildNpmPackage { src = ./.; npmBuild = "npm run build"; }; }

