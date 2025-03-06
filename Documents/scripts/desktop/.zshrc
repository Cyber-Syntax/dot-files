# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# -------------------------------------------------------------------
# Completion and compinit: autoload and initialize completion.
# -------------------------------------------------------------------
autoload -U compinit && compinit

# -------------------------------------------------------------------
# History
# -------------------------------------------------------------------
# Set history file path and limits.
HISTFILE="$HOME/.histfile"
HISTSIZE=10000
SAVEHIST=10000


plugins=( 
    zsh-autosuggestions
    zsh-autosuggestions
    dirhistory
    #TESTING: 
    zsh-navigation-tools
    git
    ssh
    npm
    pip
    python
)
# -------------------------------------------------------------------
# Aliases
# -------------------------------------------------------------------

# Docusaurus deployment alias
alias dino-deploy="yarn build & USE_SSH=true yarn deploy"

# # NixOS related aliases
# alias stable-flu="sudo nix flake update home-manager nixvim nixpkgs firefox-addons nixos-hardware"
# alias all-flu="sudo nix flake update"
# alias boot-nixos="sudo nixos-rebuild boot --flake .#nixos"
# alias boot-laptop="sudo nixos-rebuild boot --flake .#laptop"
# alias switch-nixos="sudo nixos-rebuild switch --flake .#nixos"
# alias upgrade-nixos="sudo nixos-rebuild switch --recreate-lock-file --flake .#nixos"
# alias switch-laptop="sudo nixos-rebuild switch --flake .#laptop"
# alias upgrade-laptop="sudo nixos-rebuild switch --recreate-lock-file --flake .#laptop"
# alias ll-nix="ll /nix/var/nix/profiles"
# alias switch-gen="sudo nix-env --profile /nix/var/nix/profiles/system --switch-generation"
# alias del-gen="sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations"

# Git bare repo aliases
alias bare='git --git-dir=$HOME/dotfiles --work-tree=$HOME'
alias bst='git --git-dir=$HOME/dotfiles --work-tree=$HOME status'
alias bfetch='git --git-dir=$HOME/dotfiles --work-tree=$HOME fetch origin bare-repo'
alias breset='git --git-dir=$HOME/dotfiles --work-tree=$HOME reset --hard origin/bare-repo'
alias bpull='git --git-dir=$HOME/dotfiles --work-tree=$HOME pull origin bare-repo'
alias bsingle-log='git --git-dir=$HOME/dotfiles --work-tree=$HOME log --follow -p --'
alias badog='git --git-dir=$HOME/dotfiles --work-tree=$HOME log --all --decorate --oneline --graph'
alias badd='git --git-dir=$HOME/dotfiles --work-tree=$HOME add'
alias badd-all='git --git-dir=$HOME/dotfiles --work-tree=$HOME add ~/Documents/scripts ~/.config/nvim ~/.config/qtile/ ~/.config/kitty/ ~/.config/dunst/ ~/.config/hypr/ ~/.config/waybar/ ~/.config/awesome/'
alias bcmt='git --git-dir=$HOME/dotfiles --work-tree=$HOME commit -am'
alias bpush='git --git-dir=$HOME/dotfiles --work-tree=$HOME push -u origin bare-repo'

# Standard Git aliases
alias gst="git status"
alias gbr="git branch"
alias gcko="git checkout"
alias gcmt="git commit -am"
alias gdf="git diff"
alias adog="log --all --decorate --oneline --graph"

# Other aliases
alias icat="kitten icat"  # Kitty terminal image preview

# Neovim related aliases
# alias n="nvim -c 'FzfLua oldfiles'"

alias n="nvim -c 'Telescope oldfiles'"
alias nlv="NVIM_APPNAME=nvim.lazyvim nvim -c 'Telescope oldfiles'"

# General utility aliases
alias tp="trash-put"
alias c="clear"
alias h="history"
alias ff="fastfetch"
alias grep="grep --color=auto"
alias sudov="sudo -v"
alias e="eza -F --all"
alias e2="eza -F --all --long --sort=size --total-size --tree --level=2"
alias e3="eza -F --all --long --sort=size --total-size --tree --level=3"
alias ee="eza -F --all --long --sort=size --total-size --group"
alias duh="du -sh * | sort -h"
alias duhdot="du -sh .[^.]* * | sort -h"


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# -------------------------------------------------------------------
# Extra shell initialization
# -------------------------------------------------------------------

# Bind Ctrl+Space to accept autosuggestion (the escape sequence here may need adjustments depending on terminal emulator)
bindkey '^@' autosuggest-accept

# # Source the Powerlevel10k theme, if installed.
# if [ -f "$HOME/powerlevel10k/powerlevel10k.zsh-theme" ]; then
#   source "$HOME/powerlevel10k/powerlevel10k.zsh-theme"
# fi

# Enable wayland on kitty if running on wayland
if [ "$WAYLAND_DISPLAY" ]; then
  export KITTY_ENABLE_WAYLAND=1
fi
# force x11 kitty -o "linux_display_server=x11"

# If a personal Powerlevel10k configuration exists, source it.
if [ -f "$HOME/.p10k.zsh" ]; then
  source "$HOME/.p10k.zsh"
fi

# Additional keybindings
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
# ctrl + z to undo
bindkey '^Z' undo

# bindkey '^[[Z' reverse-menu-complete


# Add custom Rofi scripts directory to PATH.
export PATH="$HOME/.config/rofi/scripts:$PATH"

# Add the user's local bin directory (as defined by xdg-user-dir) to PATH.
export PATH="$PATH:$(xdg-user-dir USER)/.local/bin"

# Initialize zoxide for fast directory navigation.
if command -v zoxide > /dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# End of .zshrc

