#!/bin/bash

# Étape 1 : Exécution du script de setup Hyprland
echo "▶️ Lancement du script Hyprland distant..."
bash <(curl -s "https://end-4.github.io/dots-hyprland-wiki/setup.sh")

# Étape 2 : Mise à jour des dépôts
echo "🔄 Mise à jour des paquets..."
sudo pacman -Syu --noconfirm

# Étape 3 : Installation des paquets officiels
echo "📦 Installation de paquets²..."
sudo pacman -S --noconfirm wofi nautilus kitty discord python

# Étape 4 : Installation de yay et paru si non présents
if ! command -v yay &> /dev/null; then
    echo "🛠 Installation de yay..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

if ! command -v paru &> /dev/null; then
    echo "🛠 Installation de paru..."
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm
    cd ..
    rm -rf paru
fi

# Étape 5 : Installation du paquet AUR zen-browser-bin
echo "🌐 Installation de zen-browser-bin via yay..."
yay -S --noconfirm zen-browser-bin

# Étape 6 : Remplacement du dossier Hyprland config
echo "📁 Remplacement de ~/.config/hypr par ./config/hypr..."
rm -rf ~/.config/hypr
cp -r ./config/hypr ~/.config/

# Étape 7 : Configuration de wofi
echo "📁 Configuration de Wofi avec ./config/wofi..."
mkdir -p ~/.config/wofi
cp -r ./config/wofi/* ~/.config/wofi/

echo "✅ Installation complète ! Redémarre Hyprland pour appliquer les changements."
