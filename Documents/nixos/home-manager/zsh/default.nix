{ pkgs, ... }:

{
  home-manager.users.developer.programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "dirhistory"
      ];
    };
    enableCompletion = true;
    completionInit = "autoload -U compinit && compinit"; # default
    dotDir = ".config/zsh";

    autosuggestion.enable = true;
    autosuggestion.highlight = "bold,underline fg=white,bold";
    #NOTE: stable 24.05 not use this 
    #autosuggestion.strategy = [ "history" ]; # default
    syntaxHighlighting.enable = true;
    history.path = "$HOME/.histfile";
    history.save = 10000;
    history.size = 10000;

    plugins = [
      #TODO: add this after qtile build issue solved
      # {
      #   name = "zsh-syntax-highlighting";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "zsh-users";
      #     repo = "zsh-syntax-highlighting";
      #     rev = "0.8.0";
      #     sha256 = "iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
      #   };
      # }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
        };
      }
      {
        name = "you-should-use";
        src = pkgs.fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-you-should-use";
          rev = "1.8.0";
          sha256 = "fJX748lwVP1+GF/aIl1J3c6XAy/AtYCpEHsP8weUNo0=";
        };
      }
      #TODO: switch to plugins instead of .zshrc for more easy way to declare nixos

      # {
      #   name = "powerlevel10k-config";
      #   src = ./.;
      #   file = "p10k.zsh";
      # }
      # {
      #   name = "zsh-powerlevel10k";
      #   src = pkgs.zsh-powerlevel10k;
      #   file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      # }
    ];

    shellAliases = {
      # nixos
      switch-upgrade = "sudo nixos-rebuild switch --upgrade"; # NOTE: this not needed when using flake
      switch = "sudo nixos-rebuild switch";
      flake-update = "sudo nix flake update"; # NOTE: this is going to be used for updating packages instead of switch-upgrade
      switch-nixos = "sudo nixos-rebuild switch --flake .#nixos";
      switch-laptop = "sudo nixos-rebuild switch --flake .#laptop";
      ll-nix = "ll /nix/var/nix/profiles";
      switch-gen = "sudo nix-env --profile /nix/var/nix/profiles/system --switch-generation";
      del-gen = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations";
      # git bare repo
      bare = "git --git-dir=$HOME/dotfiles --work-tree=$HOME";
      bst = "git --git-dir=$HOME/dotfiles --work-tree=$HOME status";
      bfetch = "git --git-dir=$HOME/dotfiles --work-tree=$HOME fetch origin bare-repo";
      breset = "git --git-dir=$HOME/dotfiles --work-tree=$HOME reset --hard origin/bare-repo";
      bpull = "git --git-dir=$HOME/dotfiles --work-tree=$HOME pull origin bare-repo";
      bsingle-log = "git --git-dir=$HOME/dotfiles --work-tree=$HOME log --follow -p --";
      badog = "git --git-dir=$HOME/dotfiles --work-tree=$HOME log --all --decorate --oneline --graph";
      badd = "git --git-dir=$HOME/dotfiles --work-tree=$HOME add";
      badd-all = "git --git-dir=$HOME/dotfiles --work-tree=$HOME add ~/Documents/nixos/ ~/Documents/screenloyout/ ~/.config/nvim ~/.config/qtile/ ~/.config/kitty/ ~/.config/dunst/ ";
      bcmt = "git --git-dir=$HOME/dotfiles --work-tree=$HOME commit -am";
      bpush = "git --git-dir=$HOME/dotfiles --work-tree=$HOME push -u origin bare-repo";
      # git aliases
      gst = "git status";
      gbr = "git branch";
      gck = "checkout";
      gcm = "commit";
      gdif = "diff";
      adog = "log --all --decorate --oneline --graph";
      # others
      icat = "kitten icat"; # kitty terminal image preview
      # neovim
      n = "nvim -c 'FzfLua oldfiles'"; # old: Telescope oldfiles
      #TESTING:
      nlv = "NVIM_APPNAME=nvim.lazyvim nvim -c 'Telescope oldfiles'";
      # general
      tp = "trash-put";
      c = "clear";
      h = "history";
      ff = "fastfetch";
      grep = "grep --color=auto";
      sudov = "sudo -v";
      e = "eza -F --all";
      e2 = "eza -F --all --long --sort=size --total-size --tree --level=2 ";
      e3 = "eza -F --all --long --sort=size --total-size --tree --level=3 ";
      ee = "eza -F --all --long --sort=size --total-size --group";

      # ls="ls --color=auto";
      # ll = "ls -alh";
      # la = "ls -A";
      # lh = "ls --human-readable --size -1 -S --classify";
      # l = "ls -CF";
      duh = "du -sh * | sort -h";
    };

    initExtra = ''
      # Ctrl + Space accept autosuggestion
      bindkey '^@' autosuggest-accept

      # sources
      source ~/powerlevel10k/powerlevel10k.zsh-theme


      # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      bindkey '^[[H' beginning-of-line
      bindkey '^[[F' end-of-line
      bindkey '^[[1;5D' backward-word
      bindkey '^[[1;5C' forward-word
      # Rofi custom themes
      export PATH=$HOME/.config/rofi/scripts:$PATH

      # add support .local/bin xdg, useful for mason.nvim to work?
      export PATH=$PATH:$(xdg-user-dir USER)/.local/bin

      # import zoxide
      eval "$(zoxide init zsh)"
    '';

  };
}
