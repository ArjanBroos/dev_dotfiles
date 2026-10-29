#!/usr/bin/env bash
set -euo pipefail

source "$(dirname -- "${BASH_SOURCE[0]}")/lib.sh"
require_user

sudo pacman -Syu --needed \
  oh-my-zsh-git zsh-theme-powerlevel10k zsh tmux neovim git stow eza lazygit ripgrep fd \
  curl unzip procps-ng ttf-jetbrains-mono-nerd

finish_setup
