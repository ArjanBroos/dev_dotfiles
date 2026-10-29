#!/usr/bin/env bash
set -euo pipefail

source "$(dirname -- "${BASH_SOURCE[0]}")/lib.sh"
require_user
source /etc/os-release
if [[ "$ID" != ubuntu ]] || (( ${VERSION_ID%%.*} < 24 )); then
  printf 'This script supports Ubuntu 24.04 or newer.\n' >&2
  exit 1
fi

sudo apt-get update
sudo apt-get install -y \
  zsh tmux git stow eza ripgrep fd-find curl ca-certificates \
  unzip xz-utils fontconfig procps

export PATH="$HOME/.local/bin:$PATH"
nvim_version=0.12.6
lazygit_version=0.66.2
nerd_fonts_version=3.5.1
case "$(uname -m)" in
  x86_64)
    arch=x86_64
    nvim_checksum=474430d53e6264f6d6dd18db42d6dc9df3a1b56ca9e88a325bbf860e1a811d87
    lazygit_checksum=158efc9ddfa1241fab5fb3526bb442c8dc6c4b1904d73213b9e4e93e03c52034 ;;
  aarch64|arm64)
    arch=arm64
    nvim_checksum=8f1f64a0bdb97247034038c3823c6cbad5bdf9ecd5751b85494b71c3ee04c815
    lazygit_checksum=79a3161eeb642f0473e23db6341f7baabd4a5933e921a9c1167c5d5c765c41a4 ;;
  *) printf 'Downloads support x86_64 and ARM64.\n' >&2; exit 1 ;;
esac
work_dir=$(mktemp -d)
trap 'rm -rf -- "$work_dir"' EXIT
mkdir -p "$HOME/.local/bin"

if ! command -v nvim >/dev/null || ! nvim --headless -u NONE -i NONE \
  '+lua local v = vim.version(); if v.major ~= 0 or v.minor ~= 12 then vim.cmd("cquit 1") end' \
  '+qa!' >/dev/null 2>&1; then
  curl --fail --location --retry 3 --output "$work_dir/nvim.tar.gz" \
    "https://github.com/neovim/neovim/releases/download/v$nvim_version/nvim-linux-$arch.tar.gz"
  printf '%s  %s\n' "$nvim_checksum" "$work_dir/nvim.tar.gz" | sha256sum --check --status
  tar -xzf "$work_dir/nvim.tar.gz" -C "$work_dir"
  nvim_dir="$HOME/.local/opt/nvim-$nvim_version"
  mkdir -p "$nvim_dir" "$HOME/.local/bin"
  cp -a "$work_dir/nvim-linux-$arch/." "$nvim_dir/"
  ln -sfn "$nvim_dir/bin/nvim" "$HOME/.local/bin/nvim"
  hash -r
fi
nvim --headless -u NONE -i NONE \
  '+lua local v = vim.version(); if v.major ~= 0 or v.minor ~= 12 then vim.cmd("cquit 1") end' '+qa!'

if ! command -v lazygit >/dev/null; then
  curl --fail --location --retry 3 --output "$work_dir/lazygit.tar.gz" \
    "https://github.com/jesseduffield/lazygit/releases/download/v$lazygit_version/lazygit_${lazygit_version}_linux_$arch.tar.gz"
  printf '%s  %s\n' "$lazygit_checksum" "$work_dir/lazygit.tar.gz" | sha256sum --check --status
  tar -xzf "$work_dir/lazygit.tar.gz" -C "$work_dir" lazygit
  install -m 755 "$work_dir/lazygit" "$HOME/.local/bin/lazygit"
fi

if ! fc-list : family | grep 'JetBrainsMono Nerd Font' >/dev/null; then
  curl --fail --location --retry 3 --output "$work_dir/fonts.tar.xz" \
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v$nerd_fonts_version/JetBrainsMono.tar.xz"
  printf '%s  %s\n' 04d5e8f903693f9dd13e16f867e994834e681eb3c72c0d337a770dcda09010cf \
    "$work_dir/fonts.tar.xz" | sha256sum --check --status
  font_dir="$HOME/.local/share/fonts/JetBrainsMono"
  mkdir -p "$work_dir/fonts" "$font_dir"
  tar -xJf "$work_dir/fonts.tar.xz" -C "$work_dir/fonts"
  find "$work_dir/fonts" -type f -name '*.ttf' -exec install -m 644 -t "$font_dir" {} +
  fc-cache -f "$font_dir"
fi

zsh_data="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
mkdir -p "$zsh_data"
clone_if_missing https://github.com/ohmyzsh/ohmyzsh.git "$zsh_data/oh-my-zsh"
clone_if_missing https://github.com/romkatv/powerlevel10k.git "$zsh_data/powerlevel10k"

finish_setup
