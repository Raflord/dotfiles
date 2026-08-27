# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

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

eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/home/rafael/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

source <(fzf --zsh)

[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

# bun completions
[ -s "/home/rafael/.bun/_bun" ] && source "/home/rafael/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
