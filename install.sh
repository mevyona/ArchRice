#!/bin/bash

set -e

# 1. Vérifier la connexion réseau avant de commencer
echo "➡️ Vérification de la connexion réseau..."
if ! nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' > /dev/null; then
    echo "🔴 Vous n'êtes pas connecté à un réseau. Veuillez vous connecter à un réseau Wi-Fi et relancer le script."
    exit 1
fi

# 2. Mise à jour du système
echo "➡️ Mise à jour du système"
sudo pacman -Syu --noconfirm

# 3. Installation des paquets de base
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
  bash-completion \
  zsh-syntax-highlighting \
  zsh-autosuggestions \
  powerlevel10k

# 4. Installation de paru (AUR helper)
echo "➡️ Installation de paru (AUR helper)"
cd /opt
sudo git clone https://aur.archlinux.org/paru.git
sudo chown -R $USER:$USER paru
cd paru
makepkg -si --noconfirm

# 5. Installation de yay (AUR helper)
echo "➡️ Installation de yay (AUR helper)"
cd /opt
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R $USER:$USER yay
cd yay
makepkg -si --noconfirm

# 6. Installation de Zen Browser (AUR)
echo "➡️ Installation de Zen Browser (AUR)"
yay -S --noconfirm zen-browser-bin

# 7. Activation de NetworkManager
echo "➡️ Activation de NetworkManager"
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

# 8. Configuration du clavier en AZERTY
echo "➡️ Configuration du clavier en AZERTY"
localectl set-keymap fr

# 9. Définition du nom de la machine
echo "➡️ Définition du nom de la machine"
sudo hostnamectl set-hostname archlinux

# 10. Copie des dotfiles (Hyprland, Waybar, etc.)
echo "➡️ Copie des dotfiles (Hyprland, Waybar...)"
mkdir -p ~/.config
cp -r config/* ~/.config/
cp config/zsh/.zshrc ~/.zshrc

# 11. Installation de Oh My Zsh
echo "➡️ Installation d'Oh My Zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# 12. Installation des plugins et Powerlevel10k
echo "➡️ Installation des plugins Zsh et Powerlevel10k"
# Plugins (autosuggestions, syntax-highlighting, etc.)
if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/plugins/zsh-autosuggestions
fi

if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting
fi

# Powerlevel10k
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi

# 13. Passage à zsh
echo "➡️ Passage à zsh"
chsh -s /bin/zsh

echo "✅ Configuration terminée ! Redémarre pour appliquer tout."