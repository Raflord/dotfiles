# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
    git
    zsh-autosuggestions
)


source "$ZSH/oh-my-zsh.sh"


# Environment variables
export EDITOR="nvim"
export VISUAL="nvim"

export GOPATH="$HOME/go"
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/go/bin:/usr/local/go/bin:$PATH"

export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

export HYPRSHOT_DIR="$HOME/Screenshots"


# Aliases
alias pn="pnpm"
alias vim="nvim"

alias venv="source .venv/bin/activate"

alias keyboard="sudo chown $USER:$USER /dev/hidraw2"


# Shell
printf '\e[6 q' # Set beam cursor


# Tools
eval "$(zoxide init zsh)"

source <(fzf --zsh)

[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"
