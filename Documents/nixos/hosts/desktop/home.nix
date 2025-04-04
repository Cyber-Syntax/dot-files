{
  pkgs,
  nixvim,
  ...
}: {
  imports = [
    #./../../home-manager/qtile.nix
    #./../../home-manager/firefox.nix
    #./../../home-manager/zsh.nix
    # nixvim.homeManagerModules.nixvim
    # ./../../modules/commonModules/nixvim/config/nixvim.nix
  ];

  home.username = "developer";
  home.homeDirectory = "/home/developer";

  home = {
    preferXdgDirectories = true;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    lxappearance
    # # fonts
    # roboto

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/developer/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    #Default enabled on hyprland.nix for general
    # NIXOS_OZONE_WL = "1"; # # Enable wayland for chromium-based apps (VSCode Discord Brave)
    # MOZ_ENABLE_WAYLAND = "1";
    # XDG_SESSION_TYPE = "wayland";
    # XDG_CURRENT_DESKTOP = "Hyprland";
    # XDG_SESSION_DESKTOP = "Hyprland";
    # SDL_VIDEODRIVER = "wayland";
    # QT_QPA_PLATFORM = "wayland";
    # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # _JAVA_AWT_WM_NONREPARENTING = "1";
    # MOZ_DISABLE_RDD_SANDBOX = "1";
    # WLR_NO_HARDWARE_CURSORS = "1";

    #NOTE: I don't think that's necessasry for now
    # XDG_CACHE_HOME = "\${HOME}/.cache";
    # XDG_CONFIG_HOME = "\${HOME}/.config";
    # XDG_BIN_HOME = "\${HOME}/.local/bin";
    # XDG_DATA_HOME = "\${HOME}/.local/share";
    # GBM_BACKEND = "nvidia-drm";
    # WINEARCH = "win64";
    # WINEPREFIX = "$HOME/.wine";
    # __GL_GSYNC_ALLOWED = "0";
    # GDK_BACKEND = "wayland";
    # WLR_DRM_NO_ATOMIC = "1";
    # WLR_BACKEND = "auto";
    # GBM_BACKEND = "nvidia";
    # __GLX_RENDERER = "nvidia";
    # _JAVA_AWT_WM_NONEREPARENTING = "1";
    # DISABLE_QT5_COMPAT = "0";
    # QT_STYLE_OVERRIDE = "kvantum";
    # GTK_THEME = "Adwaita-dark";
  };

  # home-manager.useUserPackages = false;
  #
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you
  # do want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
