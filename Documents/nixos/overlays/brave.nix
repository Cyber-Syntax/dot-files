#NOTE: Not used for now
{
  #TESTING: use this after you solve flake issue
  # not used for now

  # prevent kdewallet core dump issue
  nixpkgs.config.overlays = [
        (self: super: {
          brave = super.brave.override {
            commandLineArgs =
              "--password-store=basic";
          };
        })
  ];

}

