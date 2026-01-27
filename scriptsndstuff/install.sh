#!/bin/bash

set -euo pipefail

# Ask to run with sudo if not already
if [[ $EUID -ne 0 ]]; then
  echo "Run this script with: sudo $0"
  exit 1
fi

USER_HOME=$(eval echo "~$SUDO_USER")

### Versions & Variables
LOCALSEND_VERSION="1.17.0"
NEOVIM_VERSION="v0.11.4"
OBSIDIAN_VERSION="1.9.14"

FONTS_DIR="$USER_HOME/.local/share/fonts"
TEMP_DIR="/tmp/setup-downloads"

mkdir -p "$TEMP_DIR"
mkdir -p "$FONTS_DIR"

echo "==> Starting system setup..."
# ----------------------------
# System Update
# ----------------------------
echo "Updating your system..."
sudo apt update && sudo apt upgrade -y

# ----------------------------
# Core Packages
# ----------------------------
echo "Installing core packages..."
sudo apt install -y \
  build-essential git lazygit wget curl unzip 7zip cmake \
  fd-find ripgrep ncdu tealdeer hsetroot btop \
  python3 python3-pip pipx \
  nodejs npm \
  tmux zsh fzf zoxide eza \
  i3 xorg xcape lightdm \
  bluez bluez-utils \
  dbus-x11 libnotify-bin \
  jq psmisc rlwrap network-manager \
  ffmpeg poppler-utils imagemagick calcurse yt-dlp neomutt \
  brightnessctl rsync stow flameshot \
  fastfetch polybar rofi sxiv \
  zathura mpv qutebrowser ddgr w3m thunar \
  rxvt-unicode xsel lxappearance scrot caffeine \
  pipewire pipewire-audio-client-libraries wireplumber pipewire-pulse pulseaudio-utils \
  obs-studio gimp

xdg-mime default org.pwmt.zathura.desktop application/pdf
systemctl --user enable --now pipewire pipewire-pulse wireplumber

sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service


# ----------------------------
# Python Tools
# ----------------------------
pipx install pywal16
pipx ensurepath

# ----------------------------
# LocalSend
# ----------------------------
echo "Installing LocalSend..."
wget https://github.com/localsend/localsend/releases/download/v1.17.0/LocalSend-1.17.0-linux-x86-64.deb
sudo apt install ./LocalSend-1.17.0-linux-x86-64.deb

# ----------------------------
# Docker
# ----------------------------
echo "Setting up Docker..."
sudo apt install -y ca-certificates curl gnupg lsb-release
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER

# ----------------------------
# Lazydocker
# ----------------------------
echo "Installing Lazydocker..."
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
sudo mv ~/.local/bin/lazydocker /usr/local/bin/lazydocker

# ----------------------------
# Flatpak
# ----------------------------
echo "Setting up Flatpak..."
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# ----------------------------
# LibreWolf Browser
# ----------------------------
echo "Installing LibreWolf..."
sudo apt update && sudo apt install -y extrepo
sudo extrepo enable librewolf
sudo apt update && sudo apt install -y librewolf

# ----------------------------
# Chrome Browser
# ----------------------------
echo "Installing Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb

# ----------------------------
# Obsidian
# ----------------------------
echo "Installing Obsidian..."
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.9.14/obsidian_1.9.14_amd64.deb
sudo apt install ./obsidian_1.9.14_amd64.deb

# ----------------------------
# Yazi
# ----------------------------
echo "Installing Yazi..."
curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg
echo "deb https://debian.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" | sudo tee /etc/apt/sources.list.d/debian.griffo.io.list
sudo apt update
sudo apt install -y yazi

# ----------------------------
# Neovim & LazyVim
# ----------------------------
echo "Installing Neovim & LazyVim..."
wget https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-x86_64.appimage
mv nvim-linux-x86_64.appimage nvim
chmod +x nvim
sudo mv nvim /usr/local/bin
#git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
git clone https://github.com/LazyVim/starter ~/.config/nvim

# ----------------------------
# NPM Fancy Stuff
# ----------------------------
echo "Installing global npm packages..."
npm install -g oh-my-logo

# ----------------------------
# Fonts (JetBrainsMono Nerd)
# ----------------------------
echo "Installing Nerd Fonts..."
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
cd ~/.local/share/fonts
unzip JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -fv

# ----------------------------
# VM Stuff (QEMU, Libvirt, Virt-Manager)
# ----------------------------
echo "Setting up VM tools..."
sudo apt install -y qemu-kvm qemu-system qemu-utils libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager
sudo virsh net-start default
sudo virsh net-autostart default

sudo usermod -aG libvirt $USER
sudo usermod -aG libvirt-qemu $USER
sudo usermod -aG kvm $USER
sudo usermod -aG input $USER
sudo usermod -aG disk $USER

# ----------------------------
# Transmission
# ----------------------------
git clone --recurse-submodules https://github.com/transmission/transmission Transmission
cd Transmission
cmake -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo
cd build
cmake --build .
sudo cmake --install .

# ----------------------------
# cheat.sh ()
# ----------------------------
curl -s https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh && sudo chmod +x /usr/local/bin/cht.sh

echo "All done! Reboot recommended."

# Kanata
wget https://github.com/jtroo/kanata/releases/download/v1.10.0/linux-binaries-x64-v1.10.0.zip
unzip linux-binaries-x64-v1.10.0.zip
sudo mv kanata_linux_x64 /usr/local/bin/kanata
