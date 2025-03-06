export TERM=xterm
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/developer/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

###ALIASES###

# LS aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# alias for git bare repo
alias git-bare_n='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME' 

#same needed shortcuts.
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Ctrl + Space accept autosuggestion
bindkey '^@' autosuggest-accept

# sources
source ~/powerlevel10k/powerlevel10k.zsh-theme
#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -U compinit colors vcs_info
colors
compinit

# user-friendly command output
export CLICOLOR=1
ls --color=auto &> /dev/null && alias ls='ls --color=auto'

# Rofi custom themes
export PATH=$HOME/.config/rofi/scripts:$PATH

# export .local/bin xdg
export PATH=$PATH:$(xdg-user-dir USER)/.local/bin

# import zoxide
eval "$(zoxide init zsh)"
