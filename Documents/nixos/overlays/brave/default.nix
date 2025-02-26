{
  # prevent kdewallet core dump issue
  nixpkgs.overlays = [
    (self: super: {
      brave = super.brave.override {
        commandLineArgs = "--password-store=basic";
      };
    })
  ];
}
