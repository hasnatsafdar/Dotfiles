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

# ╭──────────────────────────────────────────────╮
# │ Zinit Bootstrap (self-installing + portable) │
# ╰──────────────────────────────────────────────╯
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

PATH="$HOME/.go/bin:$PATH"
# Created by `pipx`
export PATH="$PATH:/home/haxnet/.local/bin"
export LESS_TERMCAP_mb=$(tput bold; tput setaf 1)
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# ╭──────────────────────────────────────────────╮
# │ History and Core Options                     │
# ╰──────────────────────────────────────────────╯
HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

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
eval "$(register-python-argcomplete pipx)"

# ╭──────────────────────────────────────────────╮
# │ Prompt                                       │
# ╰──────────────────────────────────────────────╯
# Install oh-my-posh if missing
if ! command -v oh-my-posh >/dev/null 2>&1; then
    echo "Installing oh-my-posh..."
    curl -s https://ohmyposh.dev/install.sh | bash -s
    sudo mv ~/.local/bin/oh-my-posh /usr/local/bin/oh-my-posh
fi
#eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
#eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/powerlevel10k_lean.omp.json)"
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/catppuccin_mocha.omp.json)"

# ╭──────────────────────────────────────────────╮
# │ Aliases                                      │
# ╰──────────────────────────────────────────────╯
# TODO alias (function) for dd command to burn iso to usb
# TODO some cool aliases from omarchy
# ---- File Management ---- using /bin/xx instead of xx directly so scripts work fine.
cdl() { cd "$@" && eza -lh --icons --group-directories-first --color=always | head -n 50; } # auto ls when cd into a dir
alias bat='/bin/batcat'
alias c='/bin/clear'
alias cp='/bin/cp -iv'
alias cpr='/bin/cp -ivr'
alias mkdir='/bin/mkdir -pv'
alias mv='/bin/mv -iv'
alias mvr='/bin/mv -ivr'
alias rm='/bin/rm -i'
alias rmf='/bin/rm -rf'
alias rmb='/bin/mv -t ~/.local/share/Trash/files/'

# ---- eza / ls replacements ----
alias ls='eza --icons=always'
alias l='eza -lh --icons --group-directories-first --color=always'
alias la='eza -a --icons --group-directories-first --color=always'
alias ll='eza -lah --icons --group-directories-first --color=always'
alias lt='eza -T --icons --group-directories-first --color=always'

# ---- Quality of Life ----
alias fzf="fzf --preview='cat {}'"
alias i='sudo apt install -y'
alias ld='lazydocker'
alias lg='lazygit'
alias s='BROWSER=w3m ddgr' # Search the browser (DuckDuckgo)
alias v='nvim'

# ---- Fancy stuff ----
alias ff='fastfetch --logo debian -c /usr/share/fastfetch/presets/examples/10.jsonc'
alias ffs='fastfetch -c ~/.config/fastfetch/fastfetch.jsonc'
#alias pm='sudo pacman -S'
#alias pmnc='sudo pacman -S --noconfirm'

# Keybindings
#bindkey '`' autosuggest-accept
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Yazi setup
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Fancy ASCII
whoami() {
  local name
  name=$(command whoami)
  oh-my-logo "$name" ocean --filled --letter-spacing 1
}

oml() {
  oh-my-logo "$*" ocean --filled --letter-spacing 1
}

ff
