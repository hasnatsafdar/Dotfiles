# ==========================================================================;
#     ███████╗ ███████╗ ██╗  ██╗ ██████╗   ██████╗     ██████╗  ██╗   ██╗   ;
#     ╚══███╔╝ ██╔════╝ ██║  ██║ ██╔══██╗ ██╔════╝     ██╔══██╗ ╚██╗ ██╔╝   ;
#       ███╔╝  ███████╗ ███████║ ██████╔╝ ██║          ██████╔╝  ╚████╔╝    ;
#      ███╔╝   ╚════██║ ██╔══██║ ██╔══██╗ ██║          ██╔══██╗   ╚██╔╝     ;
# ██╗ ███████╗ ███████║ ██║  ██║ ██║  ██║ ╚██████╗     ██████╔╝    ██║      ;
# ╚═╝ ╚══════╝ ╚══════╝ ╚═╝  ╚═╝ ╚═╝  ╚═╝  ╚═════╝     ╚═════╝     ╚═╝      ;
# --------------------------------------------------------------------------;
# ██╗  ██╗  █████╗  ██╗  ██╗ ███╗   ██╗ ███████╗ ████████╗                  ;
# ██║  ██║ ██╔══██╗ ╚██╗██╔╝ ████╗  ██║ ██╔════╝ ╚══██╔══╝                  ;
# ███████║ ███████║  ╚███╔╝  ██╔██╗ ██║ █████╗      ██║                     ;
# ██╔══██║ ██╔══██║  ██╔██╗  ██║╚██╗██║ ██╔══╝      ██║                     ;
# ██║  ██║ ██║  ██║ ██╔╝ ██╗ ██║ ╚████║ ███████╗    ██║                     ;
# ╚═╝  ╚═╝ ╚═╝  ╚═╝ ╚═╝  ╚═╝ ╚═╝  ╚═══╝ ╚══════╝    ╚═╝                     ;
# ==========================================================================;
#
# Directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Source configs
for f in ~/.config/zsh/*; do source $f; done

# ╭──────────────────────────────────────────────╮
# │ Zinit Bootstrap (self-installing + portable) │
# ╰──────────────────────────────────────────────╯
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"
# --- #
PATH="$HOME/.go/bin:$PATH"
export PATH=$PATH:/home/hxt/.local/bin

# My extra stuff
# Created by `pipx`
export PATH="$HOME/.local/bin:$PATH"
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

export LESS_TERMCAP_mb=$(tput bold; tput setaf 1)
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

# Nix Home-Manager
#source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

# node-v24
export PATH="/home/haxnet/Downloads/node-v24.11.1-linux-x64/bin:$PATH"

# ╭──────────────────────────────────────────────╮
# │ Plugins                                      │
# ╰──────────────────────────────────────────────╯
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons=always $realpath'
zstyle 'completion:*' menu no
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons=always $realpath'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
#eval "$(register-python-argcomplete pipx)"

# ╭──────────────────────────────────────────────╮
# │ Prompt                                       │
# ╰──────────────────────────────────────────────╯
# Install oh-my-posh if missing
#if ! command -v oh-my-posh >/dev/null 2>&1; then
#    echo "Installing oh-my-posh..."
#    curl -s https://ohmyposh.dev/install.sh | bash -s
#    sudo mv ~/.local/bin/oh-my-posh /usr/local/bin/oh-my-posh
#fi
#eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
#eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/powerlevel10k_lean.omp.json)"
#eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/catppuccin_mocha.omp.json)"
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/amro.omp.json)"

###---------- ALIASES ----------###

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

if [[ ! -f /dev/shm/fetchblock ]]
then
   touch /dev/shm/fetchblock
   ff
fi
