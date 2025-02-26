{pkgs, ...}: {
  environment.pathsToLink = ["/share/zsh"];
  environment.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";

  environment.variables.EDITOR = "nvim";

  programs = {
    dconf.enable = true;
    bash.completion.enable = true; # default:true
    #https://github.com/Mic92/dotfiles/blob/1b76848e2b5951bc9041af95a834a08b68e146fd/nixos/modules/nix-ld.nix
    # programs.nix-ld.package = self.inputs.nix-ld-rs.packages.${pkgs.hostPlatform.system}.nix-ld-rs;
    ##TEST:
    # # non-nix executables like lua-language-server etc.
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      #lua
      lua-language-server
      luarocks # for lua
      stylua # lua formatter
      # markdown
      marksman
      vimPlugins.vim-markdown-toc
      markdownlint-cli2
      #python
      ruff
      mypy
      #nix
      nil
      nixfmt-rfc-style
      alejandra
      statix
      #bash, shell
      bash-language-server
      #json
      #json-lsp #FIX: find correct name
      #Other
      stdenv.cc.cc.lib
      zlib
      # html
      prettierd # TODO: need setup on neovim
      nodePackages.prettier
      yamlfmt
      stylua # lua formatter
      marksman

      ## TODO: TEST later!!
      # alsa-lib
      # at-spi2-atk
      # at-spi2-core
      # atk
      # cairo
      # curl
      # dbus
      # expat
      # fontconfig
      # freetype
      # fuse3
      # gdk-pixbuf
      # glib
      # gtk3
      # icu
      # libGL
      # libappindicator-gtk3
      # libdrm
      # libglvnd
      # libnotify
      # libpulseaudio
      # libunwind
      # libusb1
      # libuuid
      # libxkbcommon
      # mesa
      # nspr
      # nss
      # openssl
      # pango
      # pipewire
      # stdenv.cc.cc
      # systemd
      # vulkan-loader
      # zlib
    ];
    seahorse = {
      enable = true;
    };
  };
}
