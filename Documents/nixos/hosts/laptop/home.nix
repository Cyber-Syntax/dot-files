{ pkgs, ... }:

{
  imports =
    [ 
      #./../../home-manager/qtile.nix
      #./../../home-manager/firefox.nix
      #./../../home-manager/zsh.nix
    ];

    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "developer";
    home.homeDirectory = "/home/developer";

# TODO: add it later
# ## neovim
#
# programs.neovim = {
# 	enable = true;
# 	defaultEditor = true;
# };


    # programs.zsh = {
    #     enable = true;
    #     oh-my-zsh = {
    #       enable = true;
    #       plugins = [ "git" "dirhistory" ];
    #     };
    #    enableCompletion = true;
    #     completionInit = "autoload -U compinit && compinit"; # default
    #     dotDir = ".config/zsh";
    #
    #     autosuggestion.enable = true;
    #     autosuggestion.highlight = "bold,underline fg=white,bold";
    #     autosuggestion.strategy = [ "history" ]; # default
    #     syntaxHighlighting.enable = true;
    #     history.path = "$HOME/.histfile";
    #     history.save = 10000;
    #     history.size = 10000;
    #
    #     plugins = [
    #       {
    #         name = "zsh-autosuggestions";
    #         src = pkgs.fetchFromGitHub {
    #           owner = "zsh-users";
    #           repo = "zsh-autosuggestions";
    #           rev = "v0.7.0";
    #           sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
    #         };
    #       }
    #       {
    #         name = "you-should-use";
    #         src = pkgs.fetchFromGitHub {
    #           owner = "MichaelAquilina";
    #           repo = "zsh-you-should-use";
    #           rev = "1.8.0";
    #           sha256 = "fJX748lwVP1+GF/aIl1J3c6XAy/AtYCpEHsP8weUNo0=";
    #         };
    #       }
    #       {
    #         name = "powerlevel10k-config";
    #         src = ./.;
    #         file = "p10k.zsh";
    #       }
    #       {
    #         name = "zsh-powerlevel10k";
    #         src = pkgs.zsh-powerlevel10k;
    #         file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    #       }
    #      ];
    #     
    #     shellAliases = {
    #       switch = "sudo nixos-rebuild switch";
    #       switch-upgrade = "sudo nixos-rebuild switch --upgrade";
    #       git-bare = "git --git-dir=$HOME/dotfiles --work-tree=$HOME";
    #       gtst = "git status";
    #       gtbr = "git branch";
    #       gtck = "checkout";
    #       gtcm = "commit";
    #       gtdf = "diff";
    #       adog = "log --all --decorate --oneline --graph";
    #       sudov ="sudo -v";
    #       ll = "ls -alh";
    #       la = "ls -A";
    #       l = "ls -CF";
    #     };
    #
    #     initExtra = ''
    #         # Ctrl + Space accept autosuggestion
    #         bindkey '^@' autosuggest-accept
    #
    #         # sources
    #         source ~/powerlevel10k/powerlevel10k.zsh-theme
    #
    #
    #         # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    #         [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    #
    #         bindkey '^[[H' beginning-of-line
    #         bindkey '^[[F' end-of-line
    #         bindkey '^[[1;5D' backward-word
    #         bindkey '^[[1;5C' forward-word
    #         # Rofi custom themes
    #         export PATH=$HOME/.config/rofi/scripts:$PATH
    #
    #         # export .local/bin xdg
    #         export PATH=$PATH:$(xdg-user-dir USER)/.local/bin
    #
    #         # import zoxide
    #         eval "$(zoxide init zsh)"
    #     '';
    #
    #   };


    xdg = {
      enable = true;
      mime = {
        enable = true;
      };
      
      portal = {
        enable = true;
          
          extraPortals = [
            pkgs.xdg-desktop-portal-gtk
          ];
          
          config = {
            common = {
              default = [
                "gtk"
              ];
            };          
          };
      };

      mimeApps = {
        enable = true;
      };

      userDirs = {
        enable = true;
        createDirectories = true;
      };
    };
    

    home = {
      preferXdgDirectories = true;
    };


    #       gtk4.extraConfig = {
    #         Settings = ''
    #           gtk-application-prefer-dark-theme=1
    #         '';
    #       };
    #
    #       font = {
    #         name = "Roboto";
    #         size = 11;
    #       };
    #   };

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = with pkgs; [
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
      # EDITOR = "emacs";
      # GTK_THEME = "Materia-dark";
    };
    
    # 
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
    home.stateVersion = "24.05"; # Please read the comment before changing.
}
