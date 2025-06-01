#!/bin/bash

read -p "Are you sure you want to install seba's configuration? [Y/n]: " confirm
confirm=${confirm:-Y}

if [[ ! $confirm =~ ^[Yy]$ ]]; then
  echo "🚫 Installation aborted"
  exit 1
fi

echo "📦 Updating package database..."
sudo pacman -Syu 

echo "🛠️ Installing yay..."
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

echo "📥 Installing packages with yay..."
yay -S ttf-cascadia-code-nerd ttf-apple-emoji brave-bin zapzap jetbrains-toolbox onlyoffice-bin

echo "📥 Installing packages with pacman..."
sudo pacman -S telegram-desktop neovim discord spotify-launcher kitty nodejs npm zsh ripgrep thunderbird htop github-cli bitwarden fzf rclone obsidian prettier stylua bat exa unzip wl-clipboard

echo "🚀 Installing yarn..."
sudo npm install -g yarn

echo "✨ Installing pure-prompt with Yarn..."
yarn global add pure-prompt

install_ohmyzsh() {
  echo "💻 Installing oh-my-zsh..."
  RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || { echo "❌ Oh My Zsh installation failed"; exit 1; }
}

echo "🔧 Installing zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "🎨 Installing zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "📝 Applying Neovim and Kitty configurations..."

mkdir -p ~/.config/nvim
mkdir -p ~/.config/kitty

ln -sf ~/config/neovim ~/.config/nvim
ln -sf ~/config/kitty ~/.config/kitty

echo "⚙️ Applying Zsh configuration..."
ln -sf ~/config/zsh/.zshrc ~/.zshrc

echo -e "✅ Configurations applied successfully!"
