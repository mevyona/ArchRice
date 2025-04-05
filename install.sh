#!/bin/bash

set -e

# Fonction pour demander à l'utilisateur s'il souhaite installer quelque chose
ask_install() {
    while true; do
        read -p "➡️ Voulez-vous installer $1 ? (y/n) : " yn
        case $yn in
            [Yy]* ) return 0;;  # Retourne 0 pour "oui"
            [Nn]* ) return 1;;  # Retourne 1 pour "non"
            * ) echo "Réponse invalide, veuillez répondre par 'y' ou 'n'.";;
        esac
    done
}

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
  fastfetch \
  networkmanager \
  pipewire \
  pipewire-alsa \
  pipewire-jack \
  pipewire-pulse \
  ttf-dejavu \
  nautilus \
  ttf-font-awesome \
  noto-fonts \
  code \
  kitty \
  hyprland \
  waybar \
  dunst \
  grim \
  slurp \
  wl-clipboard \
  brightnessctl \
  xdg-user-dirs \
  xdg-desktop-portal-hyprland \
  zsh-syntax-highlighting \
  zsh-autosuggestions \
  playerctl \
  python \
  zenity \
  pavucontrol \
  swaylock \
  ttf-jetbrains-mono

# 4. Installation de paru (AUR helper)
echo "➡️ Installation de paru (AUR helper)"
if ask_install "paru"; then
    cd /opt
    sudo git clone https://aur.archlinux.org/paru.git
    sudo chown -R $USER:$USER paru
    cd paru
    makepkg -si --noconfirm
else
    echo "❌ Installation de paru annulée"
fi

# 5. Installation de yay (AUR helper)
echo "➡️ Installation de yay (AUR helper)"
if ask_install "yay"; then
    cd /opt
    sudo git clone https://aur.archlinux.org/yay.git
    sudo chown -R $USER:$USER yay
    cd yay
    makepkg -si --noconfirm
else
    echo "❌ Installation de yay annulée"
fi

# 6. Installation de Zen Browser (AUR)
echo "➡️ Installation de Zen Browser (AUR)"
if ask_install "Zen Browser"; then
    paru -S --noconfirm zen-browser-bin
else
    echo "❌ Installation de Zen Browser annulée"
fi

# 7. Activation de NetworkManager
echo "➡️ Activation de NetworkManager"
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

# 8. Copie des dotfiles (Hyprland, Waybar, etc.)
echo "➡️ Copie des dotfiles (Hyprland, Waybar...)"
mkdir -p ~/.config
cp -r config/* ~/.config/

# 9. Installation de Oh My Zsh
if ask_install "Oh My Zsh"; then
    echo "➡️ Installation d'Oh My Zsh"
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    # Installation des plugins Zsh
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

    # Applique les dotfiles de zsh
    cp config/zsh/.zshrc ~/.zshrc
else
    echo "❌ Installation d'Oh My Zsh annulée"
fi

# 10. Passage à zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "➡️ Passage à zsh"
    chsh -s /bin/zsh
fi

# 11. Application du thème Wofi
echo "➡️ Application du thème Wofi"
mkdir -p ~/.config/wofi

# Copie du fichier CSS du thème Wofi depuis ton dossier config/wofi
cp config/wofi/style.css ~/.config/wofi/style.css

# 12. Configuration terminée
echo "✅ Configuration terminée ! Redémarre pour appliquer tout."
