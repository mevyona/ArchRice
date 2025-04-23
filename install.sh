#!/bin/bash
bash <(curl -s "https://end-4.github.io/dots-hyprland-wiki/setup.sh")

sudo pacman -Syu --noconfirm

sudo pacman -S --noconfirm wofi nautilus kitty discord python python-pip nvidia rofi noto-fonts-emoji

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
paru -S --noconfirm zen-browser-bin visual-studio-code-bin spotify-adblock rog-control-center rofi-emoji
ç
rm -rf ~/.config/hypr
cp -r ./config/hypr ~/.config/
chmod +x ~/.config/hypr/scripts/*.sh

unzip ./fonts/Alfa_Slab_One.zip
mkdir -p ~/.fonts
mv AlfaSlabOne-Regular.ttf ~/.fonts/
fc-cache -fv

if [ -d "$HOME/.config/rofi" ]; then
  echo "Le dossier ~/.config/rofi existe déjà. Suppression du dossier."
  rm -rf "$HOME/.config/rofi"
fi
mkdir -p ~/.config/rofi
cp -r ./config/rofi/* ~/.config/rofi/

rm -rf ~/.config/fish
cp -r ./config/fish ~/.config/

sh -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"

if ! command -v spotify &> /dev/null; then
    echo "==> Installation de Spotify..."
    yay -S --noconfirm spotify
else
    echo "✔ Spotify est déjà installé."
fi

if ! command -v spicetify &> /dev/null; then
    echo "==> Installation de Spicetify CLI..."
    yay -S --noconfirm spicetify-cli
else
    echo "✔ Spicetify CLI est déjà installé."
fi

sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R

spicetify backup apply

curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh

spicetify config custom_apps marketplace

spicetify config inject_css 1 replace_colors 1 disable_sentry 1

if ! spicetify config extensions | grep -q "marketplace.js"; then
    echo "==> Ajout de marketplace.js aux extensions..."
    current_ext=$(spicetify config extensions)
    spicetify config extensions "${current_ext:+$current_ext|}marketplace.js"
fi

spicetify apply

echo "✅ Installation complète ! Redémarre Hyprland pour appliquer les changements."