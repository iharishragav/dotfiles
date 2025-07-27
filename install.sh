#!/usr/bin/env bash

set -e

echo "🚀 Starting terminal setup..."

# ────────────────────────────────────────────────────────────────
# Requirements
echo "📦 Installing dependencies..."
sudo apt update && sudo apt install -y zsh tmux curl git fonts-firacode kitty

# For Arch:
# sudo pacman -Syu --noconfirm zsh tmux starship git kitty ttf-fira-code

# ────────────────────────────────────────────────────────────────
# Zsh Plugins
echo "🔌 Installing zsh plugins..."
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
[ ! -d "$HOME/.oh-my-zsh" ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" || true

# ────────────────────────────────────────────────────────────────
# Starship Prompt
echo "✨ Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

# ────────────────────────────────────────────────────────────────
# Link Dotfiles
echo "🔗 Linking dotfiles..."

DOTFILES_DIR=$(pwd)

# Zsh
mkdir -p ~/.config/zsh
ln -sf "${DOTFILES_DIR}/zsh/.zshrc" ~/.zshrc

# Tmux
ln -sf "${DOTFILES_DIR}/tmux/.tmux.conf" ~/.tmux.conf

# Kitty
mkdir -p ~/.config/kitty
ln -sf "${DOTFILES_DIR}/kitty/kitty.conf" ~/.config/kitty/kitty.conf

# Starship
mkdir -p ~/.config
ln -sf "${DOTFILES_DIR}/starship/starship.toml" ~/.config/starship.toml

# ────────────────────────────────────────────────────────────────
# Set default shell
echo "🐚 Changing default shell to Zsh..."
chsh -s "$(which zsh)"

# ────────────────────────────────────────────────────────────────
echo "✅ Done. Please restart your terminal."
