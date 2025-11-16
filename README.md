# Dotfiles for Debian-i3wm

![Screenshot](Screenshots/screenshot.png)

---

# Debian Minimal Setup Script

## 📦 Packages to Install

```bash
sudo apt install -y \
  i3 xorg psmisc build-essential dbus-x11 libnotify-bin brightnessctl rsync stow flameshot \
  pipewire pipewire-audio-client-libraries wireplumber pipewire-pulse pulseaudio-utils \
  fastfetch polybar rofi feh \
  nodejs npm lynx tmux zsh fzf zoxide eza \
  mpv qutebrowser thunar \
  lazygit \
  rxvt-unicode xsel lxappearance scrot caffeine \
  git wget curl hsetroot btop \
  ffmpeg 7zip unzip jq poppler-utils fd-find ripgrep imagemagick
```
ly lazydocker

---

## 📥 Additional Software

### **LocalSend**

```bash
wget https://github.com/localsend/localsend/releases/download/v1.17.0/LocalSend-1.17.0-linux-x86-64.deb
sudo apt install ./LocalSend-1.17.0-linux-x86-64.deb
```

---

### **Docker**

```bash
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker run hello-world
sudo usermod -aG docker $USER
```

---

### **Flatpak**

```bash
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

---

### **LibreWolf**

```bash
sudo apt update && sudo apt install extrepo -y
sudo extrepo enable librewolf
sudo apt update && sudo apt install librewolf -y
```

---

### **Chrome**

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
```

---

### **Obsidian**

```bash
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.9.14/obsidian_1.9.14_amd64.deb
sudo apt install ./obsidian_1.9.14_amd64.deb
```

---

### **Yazi**

```bash
curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg
echo "deb https://debian.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" | sudo tee /etc/apt/sources.list.d/debian.griffo.io.list
sudo apt update
sudo apt install yazi
```

---

### **Neovim**

```bash
wget https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-x86_64.appimage
mv nvim-linux-x86_64.appimage nvim
chmod +x nvim
sudo mv nvim /usr/local/bin
```

---

### **LazyVim**

```bash
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

---

### **Fancy Stuff**

```bash
npm install -g oh-my-logo
```

---

## 🖋️ Fonts (JetBrainsMono Nerd)

```bash
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip \
&& cd ~/.local/share/fonts \
&& unzip JetBrainsMono.zip \
&& rm JetBrainsMono.zip \
&& fc-cache -fv
```

---

# ⚙️ Post-Install Configuration

## Enable Display Manager (ly)

```bash
sudo systemctl enable --now ly
```

```bash
systemctl --user enable --now pipewire pipewire-pulse wireplumber
```

---

## Set Up Zsh with Zinit and Starship (optional)

```bash
#### Install Zinit
bash -c "$(curl -fsSL https://git.io/zinit-install)"

#### Install Starship prompt
curl -sS https://starship.rs/install.sh | sh

#### Add to ~/.zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
```

---

## Set i3 as the Default Session

```bash
echo "exec i3" > ~/.xinitrc
```
