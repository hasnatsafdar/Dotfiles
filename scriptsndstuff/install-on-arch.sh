#!/bin/bash

set -euo pipefail

# Ask to run with sudo if not already
if [[ $EUID -ne 0 ]]; then
  echo "Run this script with: sudo $0"
  exit 1
fi

USER_HOME=$(eval echo "~$SUDO_USER")

echo "==> Starting system setup..."
# ----------------------------
# System Update
# ----------------------------
echo "Updating your system..."
sudo pacman -Syu

# ----------------------------
# Packages
# ----------------------------
echo "Installing core packages..."
sudo pacman -S -y \
  git neovim lazygit lazydocker wget curl unzip cmake \
  fd-find ripgrep ncdu tealdeer hsetroot btop yazi \
  python3 \
  nodejs npm \
  tmux zsh fzf zoxide eza \
  i3 xorg ly \
  bluez bluez-utils \
  dbus-x11 libnotify-bin \
  network-manager \
  ffmpeg yt-dlp \
  brightnessctl stow flameshot \
  fastfetch polybar rofi \
  zathura mpv qutebrowser ddgr w3m thunar \
  xsel lxappearance \
  pipewire pipewire-audio-client-libraries wireplumber pipewire-pulse pulseaudio-utils \

yay -S zen-browser pacseek ttf-jetbrains-mono-nerd kanata localsend \
  python-pywal16 obsidian

xdg-mime default org.pwmt.zathura.desktop application/pdf
systemctl --user enable --now pipewire pipewire-pulse wireplumber

sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

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
# Flatpak
# ----------------------------
echo "Setting up Flatpak..."
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

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

echo "All done! Reboot recommended."
