#!/usr/bin/env bash

set -Eeuo pipefail
IFS=$'\n\t'

readonly SCRIPT_NAME="${0##*/}"
readonly DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
readonly APPIMAGE_ROOT="${APPIMAGE_ROOT:-$HOME/.local/share}"
readonly APPLICATIONS_DIR="${APPLICATIONS_DIR:-$HOME/.local/share/applications}"

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
  helvum
  wiremix
  zig
  neovim
  tree-sitter-cli
  gnome-calculator
  gnome-disk-utility
)

APPIMAGE_PACKAGES=(
  helium
  openrgb
)

REMOVE_PACKAGES=(
  kitty
  dolphin
)

log() {
  printf '\n\033[1;34m[%s]\033[0m %s\n' "$SCRIPT_NAME" "$*"
}

warn() {
  printf '\033[1;33mWARNING:\033[0m %s\n' "$*" >&2
}

fail() {
  printf '\033[1;31mERROR:\033[0m %s\n' "$*" >&2
  exit 1
}

on_error() {
  local exit_code=$?
  printf '\033[1;31mERROR:\033[0m Command failed at line %s with exit code %s: %s\n' \
    "$1" "$exit_code" "$2" >&2
  exit "$exit_code"
}
trap 'on_error "$LINENO" "$BASH_COMMAND"' ERR

require_arch() {
  command -v pacman >/dev/null 2>&1 || fail "pacman was not found. This script is intended for Arch Linux."
  command -v sudo >/dev/null 2>&1 || fail "sudo is required."
}

install_pacman_packages() {
  log "Refreshing repositories and installing pacman packages..."

  local available=()
  local unavailable=()
  local package

  for package in "${PACMAN_PACKAGES[@]}"; do
    if pacman -Si -- "$package" >/dev/null 2>&1; then
      available+=("$package")
    else
      unavailable+=("$package")
    fi
  done

  if ((${#available[@]})); then
    sudo pacman -Syu --needed --noconfirm -- "${available[@]}"
  fi

  if ((${#unavailable[@]})); then
    warn "These packages were not found in the enabled pacman repositories and were skipped:"
    printf '  - %s\n' "${unavailable[@]}" >&2
    warn "They may be misspelled, unavailable for your architecture, or provided by the AUR."
  fi
}

install_appimages() {
  log "Installing AppImages from $DOTFILES_DIR..."

  mkdir -p -- "$APPIMAGE_ROOT" "$APPLICATIONS_DIR"

  local package source_dir destination_dir
  local -a appimages desktop_files

  for package in "${APPIMAGE_PACKAGES[@]}"; do
    source_dir="$DOTFILES_DIR/$package"
    destination_dir="$APPIMAGE_ROOT/$package"

    if [[ ! -d "$source_dir" ]]; then
      warn "AppImage source directory not found, skipping $package: $source_dir"
      continue
    fi

    mapfile -d '' -t appimages < <(
      find "$source_dir" -maxdepth 1 -type f -iname '*.AppImage' -print0
    )
    mapfile -d '' -t desktop_files < <(
      find "$source_dir" -maxdepth 1 -type f -iname '*.desktop' -print0
    )

    if ((${#appimages[@]} == 0)); then
      warn "No *.AppImage file found for $package in $source_dir"
      continue
    fi

    mkdir -p -- "$destination_dir"

    local file installed_appimage
    for file in "${appimages[@]}"; do
      installed_appimage="$destination_dir/${file##*/}"
      install -m 0755 -- "$file" "$installed_appimage"
      log "Installed $installed_appimage"
    done

    if ((${#desktop_files[@]} == 0)); then
      warn "No *.desktop file found for $package in $source_dir"
    else
      for file in "${desktop_files[@]}"; do
        install -m 0644 -- "$file" "$APPLICATIONS_DIR/${file##*/}"
        log "Installed $APPLICATIONS_DIR/${file##*/}"
      done
    fi
  done

  if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "$APPLICATIONS_DIR" || warn "Could not refresh the desktop application database."
  fi
}

install_cli_tools() {
  log "Installing CLI tools..."

  command -v curl >/dev/null 2>&1 || sudo pacman -S --needed --noconfirm curl

  if command -v uv >/dev/null 2>&1; then
    log "uv is already installed; skipping."
  else
    curl --proto '=https' --tlsv1.2 -LsSf https://astral.sh/uv/install.sh | sh
  fi

  if command -v pnpm >/dev/null 2>&1; then
    log "pnpm is already installed; skipping."
  else
    curl --proto '=https' --tlsv1.2 -fsSL https://get.pnpm.io/install.sh | sh -
  fi

  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    log "Oh My Zsh is already installed; skipping."
  else
    command -v zsh >/dev/null 2>&1 || sudo pacman -S --needed --noconfirm zsh
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
      "$(curl --proto '=https' --tlsv1.2 -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
}

remove_unwanted_packages() {
  log "Removing unwanted preinstalled packages..."

  local installed=()
  local package

  for package in "${REMOVE_PACKAGES[@]}"; do
    if pacman -Q -- "$package" >/dev/null 2>&1; then
      installed+=("$package")
    else
      log "$package is not installed; skipping."
    fi
  done

  if ((${#installed[@]})); then
    sudo pacman -Rns --noconfirm -- "${installed[@]}"
  fi
}

main() {
  require_arch

  # Ask for sudo once and cache the credentials before doing any work.
  sudo -v

  install_pacman_packages
  install_appimages
  install_cli_tools
  remove_unwanted_packages

  log "Setup completed. Open a new shell so uv, pnpm, and Oh My Zsh environment changes are loaded."
}

main "$@"
