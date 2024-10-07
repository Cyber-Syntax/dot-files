{ pkgs, ... }:

{
home-manager.users.developer.programs.zsh = {
        enable = true;
        oh-my-zsh = {
          enable = true;
          plugins = [ "git" "dirhistory" ];
        };
       enableCompletion = true;
        completionInit = "autoload -U compinit && compinit"; # default
        dotDir = ".config/zsh";

        autosuggestion.enable = true;
        autosuggestion.highlight = "bold,underline fg=white,bold";
        autosuggestion.strategy = [ "history" ]; # default
        syntaxHighlighting.enable = true;
        history.path = "$HOME/.histfile";
        history.save = 10000;
        history.size = 10000;

        plugins = [
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
          #NOTE: They are already included via .zshrc and I don't see any benefit of using as plugin.
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
          switch = "sudo nixos-rebuild switch";
          flake-update = "sudo nix flake update"; #NOTE: this is going to be used for updating packages etc.
          switch-upgrade = "sudo nixos-rebuild switch --upgrade"; #NOTE: this not needed when using flake
          switch-nixos = "sudo nixos-rebuild switch --flake .#nixos";
          switch-laptop = "sudo nixos-rebuild switch --flake .#laptop";
          ll-nix = "ll /nix/var/nix/profiles";
          switch-gen = "sudo nix-env --profile /nix/var/nix/profiles/system --switch-generation";
          del-gen = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations";
        # git bare repo
          bare = "git --git-dir=$HOME/dotfiles --work-tree=$HOME";
          bare-st = "git --git-dir=$HOME/dotfiles --work-tree=$HOME status";
          bare-fetch = "git --git-dir=$HOME/dotfiles --work-tree=$HOME fetch origin bare-repo";
          bare-reset = "git --git-dir=$HOME/dotfiles --work-tree=$HOME reset --hard origin/bare-repo";
          bare-pull = "git --git-dir=$HOME/dotfiles --work-tree=$HOME pull origin bare-repo";
          bare-single-log = "git --git-dir=$HOME/dotfiles --work-tree=$HOME log --follow -p --";
          bare-adog = "git --git-dir=$HOME/dotfiles --work-tree=$HOME log --all --decorate --oneline --graph";
          bare-add = "git --git-dir=$HOME/dotfiles --work-tree=$HOME add";
          bare-cmt = "git --git-dir=$HOME/dotfiles --work-tree=$HOME commit -am";
          bare-push = "git --git-dir=$HOME/dotfiles --work-tree=$HOME push -u origin bare-repo";
        # git aliases
          gtst = "git status";
          gtbr = "git branch";
          gtck = "checkout";
          gtcm = "commit";
          gtdf = "diff";
          adog = "log --all --decorate --oneline --graph";
          sudov ="sudo -v";
          ll = "ls -alh";
          la = "ls -A";
          l = "ls -CF";
          # others
          icat = "kitten icat"; # kitty terminal image preview
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
