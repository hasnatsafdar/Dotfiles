#!/bin/bash

clear

# --------------------------
# Setup for Fedora Sway Spin
# Author: hasnatsafdar
# --------------------------

set -e

REPO="https://github.com/hasnatsafdar/Dotfiles"
DOTFILES_DIR="$(pwd)"

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

info() {
  echo -e "${CYAN}[INFO]${NC} $1"
}

ask() {
  read -rp "[?] $1 (y/n): " answer
  case ${answer:0:1} in
      y|Y ) return 0;;
      * ) return 1;;
  esac
}

# Required packages
PACKAGES=(
    kitty rofi waybar zsh zoxide tmux bat fastfetch htop pyfiglet lolcat firefox \
    fzf eza zstd flatpak snapd cargo rust-analyzer docker \
    unzip wget rsync git figlet curl
)

# Optional COPR and custom installs
yazi_install() {
  sudo dnf copr enable lihaohong/yazi -y && sudo dnf install yazi -y
}

lazygit_install() {
  sudo dnf copr enable atim/lazygit -y && sudo dnf install lazygit -y
}

lazydocker_install() {
  curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
}

nerd_font_install() {
  mkdir -p ~/.local/share/fonts
  cd ~/.local/share/fonts || exit
  curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
  unzip -o JetBrainsMono.zip -d JetBrainsMono
  fc-cache -fv
  cd - || exit
}

starship_install() {
  curl -sS https://starship.rs/install.sh | sh -s -- -y
  echo 'eval "$(starship init zsh)"' >> ~/.zshrc
}

zinit_install() {
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
}

tmux_setup() {
  git clone --single-branch https://github.com/gpakosz/.tmux.git ~/.config/oh-my-tmux
  ln -sf ~/.config/oh-my-tmux/.tmux.conf ~/.config/tmux/tmux.conf
  cp ~/.config/oh-my-tmux/.tmux.conf.local ~/.config/tmux/tmux.conf.local
}

zoxide_setup() {
  echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc
}

install_packages() {
  info "Installing base packages..."
  sudo dnf install -y "${PACKAGES[@]}"
}

copy_dotfiles() {
  DOTFILES=(kitty rofi sway tmux nvim zsh waybar)
  for folder in "${DOTFILES[@]}"; do
    SRC="$DOTFILES_DIR/$folder"
    DEST="$HOME/.config/$folder"
    if [ -d "$SRC" ]; then
      info "Copying $folder → $DEST"
      mkdir -p "$DEST"
      cp -r "$SRC"/* "$DEST"/
    fi
  done
  # ZSHRC
  [ -f "$DOTFILES_DIR/.zshrc" ] && cp "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
}

main() {
  echo -e "${GREEN}Hasnat’s Fedora Sway Dotfiles Installer${NC}"

  ask "Update system first?" && sudo dnf update -y
  install_packages

  ask "Install Zinit?" && zinit_install
  ask "Install Starship?" && starship_install
  ask "Install and setup Zoxide?" && zoxide_setup
  ask "Install Oh My Tmux setup?" && tmux_setup
  ask "Install LazyGit?" && lazygit_install
  ask "Install LazyDocker?" && lazydocker_install
  ask "Install Yazi file manager?" && yazi_install
  ask "Install JetBrainsMono Nerd Font?" && nerd_font_install

  ask "Copy dotfiles from repo to ~/.config?" && copy_dotfiles

  info "Setup complete! You may want to reboot or start using your system now."
  info "Make ZSH default shell: chsh -s $(which zsh)"
}

main "$@"

