# Dotfiles

![screenshot](screenshot.png)
![screenshot2](screenshot2.png)
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

####### This is not completely configured by me (some of it is but) most of it is what i found on the official docs or from other people's customizations and then tinkered it to my liking. The reason i uploaded is so i can organize all of it in one place.

If you can understand configurations here are the **Dotfiles** 
https://github.com/hasnatsafdar/Dotfiles/ but they are by no means arranged properly or well documented. You'd relly have to help yourself....
