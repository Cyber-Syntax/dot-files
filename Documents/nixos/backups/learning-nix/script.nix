{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = [pkgs.coreutils];
  shellHook = ''
    timestamp=$(date -d @$(${pkgs.coreutils}/bin/date +%s) +%Y-%m-%d_%H-%M-%S)
    echo $timestamp
  '';
}
