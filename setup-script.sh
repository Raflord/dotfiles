#!/usr/bin/env bash

set -Eeuo pipefail
IFS=$'\n\t'

readonly SCRIPT_NAME="${0##*/}"
readonly DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

PACMAN_PACKAGES=(
    thunar
    thunar-archive-plugin
    xarchiver
    7zip
    go
    nodejs
    npm
    ttf-jetbrains-mono
    ttf-jetbrains-mono-nerd
    noto-fonts-emoji
    swaync
    power-profiles-daemon
    python-gobject
    fzf
    ripgrep
    unzip
    wl-clipboard
    obs-studio
    nwg-look
    make
    hyprshot
    hyprpaper
    hyprlock
    hypridle
    ghostty
    xdg-desktop-portal-gtk
    wiremix
    zig
    neovim
    tree-sitter-cli
    gnome-calculator
    gnome-disk-utility
    firefox
    fd
)

REMOVE_PACKAGES=(
    kitty
    dolphin
)

STOW_PACKAGES=(
    backgrounds
    ghostty
    hypr
    nvim
    waybar
    wofi
    zsh
)

log() {
    printf '\n\033[1;34m==>\033[0m %s\n' "$*"
}

warn() {
    printf '\033[1;33mWARNING:\033[0m %s\n' "$*" >&2
}

error() {
    printf '\033[1;31mERROR:\033[0m %s\n' "$*" >&2
}

on_error() {
    local exit_code=$?

    error "Command failed at line $1 (exit code $exit_code): $2"
    exit "$exit_code"
}

trap 'on_error "$LINENO" "$BASH_COMMAND"' ERR

require_command() {
    local command="$1"

    command -v "$command" >/dev/null 2>&1 ||
        {
            error "$command is required but was not found."
            exit 1
        }
}

install_pacman_packages() {
    log "Refreshing repositories and installing packages..."

    local available=()
    local unavailable=()
    local package

    for package in "$@"; do
        if pacman -Si -- "$package" >/dev/null 2>&1; then
            available+=("$package")
        else
            unavailable+=("$package")
        fi
    done

    if ((${#available[@]} > 0)); then
        sudo pacman -Syu
        --needed
        --noconfirm
        -- "${available[@]}"
    fi

    if ((${#unavailable[@]} > 0)); then
        warn "The following packages were not found and were skipped:"

        $()$(
            printf '  - %s\n' "${unavailable[@]}" >&2
        )$()

    fi
}

install_appimages() {
    log "Installing AppImages..."

    mkdir -p
    "$APPIMAGE_ROOT"
    "$APPLICATIONS_DIR"

    local package
    local source_dir
    local destination_dir
    local appimage
    local desktop_file

    for package in "${APPIMAGE_PACKAGES[@]}"; do
        source_dir="$DOTFILES_DIR/$package"
        destination_dir="$APPIMAGE_ROOT/$package"

        $()$(
            if [[ ! -d "$source_dir" ]]; then
                warn "Directory not found: $source_dir"
                continue
            fi

            mkdir -p "$destination_dir"

            shopt -s nullglob

            for appimage in "$source_dir"/*.AppImage; do
                install \
                    -Dm755 \
                    "$appimage" \
                    "$destination_dir/${appimage##*/}"
            done

            for desktop_file in "$source_dir"/*.desktop; do
                install \
                    -Dm644 \
                    "$desktop_file" \
                    "$APPLICATIONS_DIR/${desktop_file##*/}"
            done

            shopt -u nullglob
        )$()

    done

    if command -v update-desktop-database >/dev/null 2>&1; then
        update-desktop-database "$APPLICATIONS_DIR" ||
            warn "Could not update the desktop database."
    fi
}

install_uv() {
    if command -v uv >/dev/null 2>&1; then
        log "uv is already installed."
        return
    fi

    log "Installing uv..."

    curl
    --proto '=https'
    --tlsv1.2
    -LsSf
    https://astral.sh/uv/install.sh |
        sh
}

install_pnpm() {
    if command -v pnpm >/dev/null 2>&1; then
        log "pnpm is already installed."
        return
    fi

    log "Installing pnpm..."

    curl
    --proto '=https'
    --tlsv1.2
    -fsSL
    https://get.pnpm.io/install.sh |
        sh -
}

install_oh_my_zsh() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        log "Oh My Zsh is already installed."
        return
    fi

    if ! command -v zsh >/dev/null 2>&1; then
        install_pacman_packages zsh
    fi

    log "Installing Oh My Zsh..."

    RUNZSH=no
    CHSH=no
    KEEP_ZSHRC=yes
    sh -c "$(
        curl
        --proto '=https'
        --tlsv1.2
        -fsSL
        https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    )"
}

install_cli_tools() {
    log "Installing CLI tools..."

    if ! command -v curl >/dev/null 2>&1; then
        install_pacman_packages curl
    fi

    install_uv
    install_pnpm
    install_oh_my_zsh
}

remove_unwanted_packages() {
    log "Removing unwanted packages..."

    local installed=()
    local package

    for package in "${REMOVE_PACKAGES[@]}"; do
        if pacman -Q -- "$package" >/dev/null 2>&1; then
            installed+=("$package")
        fi
    done

    if ((${#installed[@]} > 0)); then
        sudo pacman -Rns
        --noconfirm
        -- "${installed[@]}"
    else
        log "No unwanted packages are installed."
    fi
}

install_stow_configs() {
    log "Stowing dotfiles..."

    if ! command -v stow >/dev/null 2>&1; then
        log "Installing GNU Stow..."
        install_pacman_packages stow
    fi

    local package

    for package in "${STOW_PACKAGES[@]}"; do
        local package_dir="$DOTFILES_DIR/$package"

        if [[ ! -d "$package_dir" ]]; then
            warn "Stow package not found: $package_dir"
            continue
        fi

        log "Stowing $package..."

        stow \
            --dir="$DOTFILES_DIR" \
            --target="$HOME" \
            --restow \
            "$package"
    done
}

main() {
    require_command pacman
    require_command sudo

    sudo -v

    install_pacman_packages
    "${PACMAN_PACKAGES[@]}"

    install_stow_configs

    install_cli_tools
    remove_unwanted_packages

    log "Setup completed."
    log "Open a new shell to load uv, pnpm, and Oh My Zsh."
}

main "$@"
