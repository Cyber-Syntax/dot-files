{pkgs, ...}: {
  programs.nixvim.plugins.dap.extensions.dap-go = {
    enable = true;
    delve.path = "${pkgs.delve}/bin/dlv";
  };
}
