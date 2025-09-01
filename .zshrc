stty -ixon

PROMPT_EOL_MARK=$'\u23CE '  

# ───────────────────────────────────────────────────────────────
# Starship prompt configuration
export STARSHIP_CONFIG="$HOME/.dotfiles/.config/starship/starship.toml"
eval "$(starship init zsh)"

# ───────────────────────────────────────────────────────────────
# Useful aliases for quick nav and tooling
alias vim="nvim"
alias vi="nvim"

# Make sure to install lazygit, check `https://github.com/jesseduffield/lazygit` for installation process
alias lgit="lazygit"

alias zr="source ~/.zshrc"
alias zshrc="vim ~/.dotfiles/.zshrc"

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# ls, the common ones I use a lot shortened for rapid fire usage
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list

# ───────────────────────────────────────────────────────────────
# Node Version Manager setup (if still used)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Add Cargo-installed binaries (e.g. sqlx) to PATH
export PATH="$HOME/.cargo/bin:$PATH"

# ───────────────────────────────────────────────────────────────
# Zinit plugin manager setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname "$ZINIT_HOME")"
[ ! -d "$ZINIT_HOME/.git" ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# ───────────────────────────────────────────────────────────────
# Enable completion system (must be before some plugins)
autoload -Uz compinit
compinit

DISABLE_AUTO_TITLE="true"

# ───────────────────────────────────────────────────────────────
# Zinit plugins
# Autosuggestions (fish-style ghost text)
zinit light zsh-users/zsh-autosuggestions

# Syntax highlighting (must be last in plugin list)
zinit light zsh-users/zsh-syntax-highlighting

# FZF-powered tab completion menu
zinit light Aloxaf/fzf-tab

# Git plugin from Oh My Zsh (aliases like gst, gco, gl)
zinit snippet https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/git.plugin.zsh

# Docker plugin from Oh My Zsh (aliases like dcu, dps)
zinit snippet https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/docker/docker.plugin.zsh

# Replace `z` with modern `zoxide`
zinit light ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

# ───────────────────────────────────────────────────────────────
# fzf-tab preview tweak (pretty previews with bat)
zstyle ':completion:*' fzf-preview \
  'bat --style=numbers --color=always --line-range :500 {} 2>/dev/null || cat {} 2>/dev/null'
zstyle ':completion:*' fzf-completion-opts '--layout=reverse --info=inline'
