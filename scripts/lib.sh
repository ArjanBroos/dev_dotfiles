#!/usr/bin/env bash

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)

require_user() {
  if (( EUID == 0 )); then
    printf 'Run this as your normal user, not with sudo; package installs will request sudo.\n' >&2
    exit 1
  fi
}

clone_if_missing() {
  local url=$1 destination=$2
  if [[ ! -e "$destination" && ! -L "$destination" ]]; then
    git clone --depth=1 "$url" "$destination"
  elif [[ ! -d "$destination/.git" ]]; then
    printf 'Refusing to overwrite existing non-Git directory: %s\n' "$destination" >&2
    return 1
  fi
}

link_dotfiles() {
  mkdir -p "$HOME/.config"
  stow --dir="$repo_dir" --target="$HOME" zsh tmux nvim
}

finish_setup() {
  clone_if_missing https://github.com/tmux-plugins/tpm.git "$HOME/.tmux/plugins/tpm"
  link_dotfiles
  printf '\nDotfiles installed. Restart your shell and Neovim.\n'
  printf 'Select JetBrainsMono Nerd Font in your terminal.\n'
  printf 'To make Zsh your login shell, run: chsh -s /usr/bin/zsh\n'
}
