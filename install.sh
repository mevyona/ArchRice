#!/bin/bash

set -e

echo "➡️ Mise à jour du système"
sudo pacman -Syu --noconfirm

echo "➡️ Installation des paquets de base"
sudo pacman -S --noconfirm \
  base-devel \
  git \
  zsh \
  neofetch \
  networkmanager \
  pipewire \
  pipewire-alsa \
  pipewire-jack \
  pipewire-pulse \
  pavucontrol \
  ttf-dejavu \
  ttf-font-awesome \
  noto-fonts \
  code \
  kitty \
  rofi \
  hyprland \
  waybar \
  dunst \
  grim \
  slurp \
  wl-clipboard \
  brightnessctl \
  pamixer \
  thunar \
  file-roller \
  gvfs \
  unzip \
  zenity \
  xdg-user-dirs \
  xdg-desktop-portal-hyprland \
  polkit-kde-agent \
  firefox \
  bash-completion

echo "➡️ Installation de yay (AUR helper)"
cd /opt
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R $USER:$USER yay
cd yay
makepkg -si --noconfirm

echo "➡️ Installation de Zen Browser (AUR)"
yay -S --noconfirm zen-browser-bin

echo "➡️ Activation de NetworkManager"
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

echo "➡️ Configuration du clavier en AZERTY"
localectl set-keymap fr

echo "➡️ Définition du nom de la machine"
sudo hostnamectl set-hostname archlinux

echo "➡️ Copie des dotfiles (Hyprland, Waybar...)"
mkdir -p ~/.config
cp -r config/* ~/.config/
cp .zshrc ~/.zshrc

echo "➡️ Passage à zsh"
chsh -s /bin/zsh

echo "✅ Configuration terminée ! Redémarre pour appliquer tout."
