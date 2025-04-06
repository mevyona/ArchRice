#!/bin/bash
bash <(curl -s "https://end-4.github.io/dots-hyprland-wiki/setup.sh")

sudo pacman -Syu --noconfirm

sudo pacman -S --noconfirm wofi nautilus kitty discord python python-pip nvidia

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

sudo pacman -Rns --noconfirm code
paru -S --noconfirm zen-browser-bin visual-studio-code-bin

rm -rf ~/.config/hypr
cp -r ./config/hypr ~/.config/


mkdir -p ~/.config/wofi
cp -r ./config/wofi/* ~/.config/wofi/

paru -S --noconfirm spotify-adblock

sh -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"

echo "✅ Installation complète ! Redémarre Hyprland pour appliquer les changements."