#!/bin/bash
bash <(curl -s "https://end-4.github.io/dots-hyprland-wiki/setup.sh")

sudo pacman -Syu --noconfirm

sudo pacman -S --noconfirm wofi nautilus kitty discord python python-pip nvidia rofi

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

sudo pacman -Rns --noconfirm code dunst
paru -S --noconfirm zen-browser-bin visual-studio-code-bin spotify-adblock rog-control-center 

rm -rf ~/.config/hypr
cp -r ./config/hypr ~/.config/
chmod +x ~/.config/hypr/scripts/*.sh

if [ -d "$HOME/.config/rofi" ]; then
  echo "Le dossier ~/.config/rofi existe déjà. Suppression du dossier."
  rm -rf "$HOME/.config/rofi"
fi
mkdir -p ~/.config/rofi
cp -r ./config/rofi/* ~/.config/rofi/

rm -rf ~/.config/fish
cp -r ./config/fish ~/.config/

sh -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"

echo "✅ Installation complète ! Redémarre Hyprland pour appliquer les changements."