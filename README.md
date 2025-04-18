# Dotfiles

Sudo dnf install 
kitty
zsh
// Zinit and starship for managing plugins
```
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
```
// Installing Starship for zsh
```
curl -sS https://starship.rs/install.sh | sh
```
zoxide
// Add this to the end of your config file (usually ~/.zshrc):
```
# Zinit plugin manager
source ~/.zinit/bin/zinit.zsh

# Plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode
zinit light zdharma-continuum/history-search-multi-word
zinit light marlonrichert/zsh-autocomplete
zinit light zsh-users/zsh-completions
# Starship prompt
eval "$(starship init zsh)"
# Zoxide
eval "$(zoxide init zsh)"
```
tmux
```
$ git clone --single-branch https://github.com/gpakosz/.tmux.git "/path/to/oh-my-tmux"
$ mkdir -p ~/.config/tmux
$ ln -s /path/to/oh-my-tmux/.tmux.conf ~/.config/tmux/tmux.conf
$ cp /path/to/oh-my-tmux/.tmux.conf.local ~/.config/tmux/tmux.conf.local
```
bat
fastfetch
htop
pyfiglet
lolcat
firefox
fzf
eza
zstd

### Jetbrains mono nerd font
https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip

flatpak
paru
snapd


###### yazi
```
dnf copr enable lihaohong/yazi
dnf install yazi
```
LazyVim
LazyDocker
```
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
```
LazyGit
```
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit
```


Obsidian
Anki
appflowey 

Docker

rust (for cargo)
```
curl https://sh.rustup.rs -sSf | sh
```
cargo install dua-cli




![screenshot](screenshot.png)
