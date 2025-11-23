#!/bin/bash

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    echo "Run this script with: sudo $0"
    exit 1
fi

USER_HOME=$(eval echo "~$SUDO_USER")

### Versions
LOCALSEND_VERSION="1.17.0"
NEOVIM_VERSION="v0.11.4"
OBSIDIAN_VERSION="1.9.14"
FONTS_DIR="$USER_HOME/.local/share/fonts"
TEMP_DIR="/tmp/setup-downloads"

mkdir -p "$TEMP_DIR"
mkdir -p "$FONTS_DIR"

echo "==> Starting system setup..."

### ───────────────────────────────────────────────
###  FUNCTIONS
### ───────────────────────────────────────────────

install_packages() {
    echo "==> Updating system"
    apt update && apt upgrade -y

    echo "==> Installing base packages"
    apt install -y \
        i3 xorg lightdm psmisc network-manager build-essential dbus-x11 libnotify-bin brightnessctl rsync stow flameshot \
        pipewire pipewire-audio-client-libraries wireplumber pipewire-pulse pulseaudio-utils \
        fastfetch polybar rofi feh \
        nodejs npm pipx lynx tmux zsh fzf zoxide eza yt-dlp calcurse neomutt \
        mpv qutebrowser thunar \
        lazygit \
        rxvt-unicode xsel lxappearance scrot caffeine \
        git wget curl ncdu hsetroot btop \
        ffmpeg 7zip unzip jq poppler-utils fd-find ripgrep imagemagick
}

install_ohmyposh() {
    echo "==> Installing Oh My Posh"
    curl -sL https://ohmyposh.dev/install.sh -o "$TEMP_DIR/omp.sh"
    bash "$TEMP_DIR/omp.sh"
}

install_pywal() {
    echo "==> Installing Pywal16"
    pipx install pywal16 || true
    pipx ensurepath
}

install_localsend() {
    echo "==> Installing LocalSend"
    wget -O "$TEMP_DIR/localsend.deb" \
        "https://github.com/localsend/localsend/releases/download/v${LOCALSEND_VERSION}/LocalSend-${LOCALSEND_VERSION}-linux-x86-64.deb"
    apt install -y "$TEMP_DIR/localsend.deb"
}

install_docker() {
    echo "==> Installing Docker"

    apt install -y ca-certificates curl gnupg lsb-release

    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg \
        | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
        > /etc/apt/sources.list.d/docker.list

    apt update
    apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    usermod -aG docker "$SUDO_USER"
}

install_lazydocker() {
    echo "==> Installing LazyDocker"
    curl -s https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh \
        -o "$TEMP_DIR/lazydocker.sh"
    bash "$TEMP_DIR/lazydocker.sh"
    mv "$USER_HOME/.local/bin/lazydocker" /usr/local/bin/lazydocker
}

install_flatpak() {
    echo "==> Setting up Flatpak & Flathub"
    apt install -y flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

install_librewolf() {
    echo "==> Installing LibreWolf"
    apt install -y extrepo
    extrepo enable librewolf
    apt update
    apt install -y librewolf
}

install_chrome() {
    echo "==> Installing Google Chrome"
    wget -O "$TEMP_DIR/chrome.deb" \
        "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
    apt install -y "$TEMP_DIR/chrome.deb"
}

install_obsidian() {
    echo "==> Installing Obsidian"
    wget -O "$TEMP_DIR/obsidian.deb" \
        "https://github.com/obsidianmd/obsidian-releases/releases/download/v${OBSIDIAN_VERSION}/obsidian_${OBSIDIAN_VERSION}_amd64.deb"
    apt install -y "$TEMP_DIR/obsidian.deb"
}

install_yazi() {
    echo "==> Installing Yazi"
    curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc \
        | gpg --dearmor -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg

    echo "deb https://debian.griffo.io/apt $(lsb_release -sc) main" \
        > /etc/apt/sources.list.d/debian.griffo.io.list

    apt update
    apt install -y yazi
}

install_neovim() {
    echo "==> Installing Neovim AppImage"
    wget -O "$TEMP_DIR/nvim.appimage" \
        "https://github.com/neovim/neovim/releases/download/${NEOVIM_VERSION}/nvim-linux-x86_64.appimage"
    chmod +x "$TEMP_DIR/nvim.appimage"
    mv "$TEMP_DIR/nvim.appimage" /usr/local/bin/nvim
}

install_lazyvim() {
    echo "==> Installing LazyVim / Kickstart"
    git clone https://github.com/nvim-lua/kickstart.nvim.git \
        "$USER_HOME/.config/nvim"
    chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/nvim"
}

install_fancy() {
    echo "==> Installing Oh My Logo"
    npm install -g oh-my-logo
}

install_fonts() {
    echo "==> Installing JetBrainsMono Nerd Font"
    wget -P "$FONTS_DIR" \
         https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip

    cd "$FONTS_DIR"
    unzip -o JetBrainsMono.zip
    rm JetBrainsMono.zip
    fc-cache -fv
}

install_vm() {
    echo "==> Installing Virtualization Packages"
    apt install -y qemu-kvm qemu-system qemu-utils python3 python3-pip \
        libvirt-clients libvirt-daemon-system bridge-utils virtinst \
        libvirt-daemon virt-manager

    virsh net-start default || true
    virsh net-autostart default || true

    usermod -aG libvirt "$SUDO_USER"
    usermod -aG libvirt-qemu "$SUDO_USER"
    usermod -aG kvm "$SUDO_USER"
}

cleanup() {
    echo "==> Cleaning up"
    rm -rf "$TEMP_DIR"
}

### ───────────────────────────────────────────────
###  EXECUTION
### ───────────────────────────────────────────────

install_packages
install_ohmyposh
install_pywal
install_localsend
install_docker
install_lazydocker
install_flatpak
install_librewolf
install_chrome
install_obsidian
install_yazi
install_neovim
install_lazyvim
install_fancy
install_fonts
install_vm
cleanup

echo "==> Setup complete. Please reboot."
