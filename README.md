# 🛠️ Dotfiles

Minimal, personal Neovim + terminal setup powered by [`lazy.nvim`](https://github.com/folke/lazy.nvim).  
Fast, clean, and ready to go - with LSP 🧠, fuzzy find 🔍, formatting ✨, autocompletion 🚀, and beautiful themes 🎨.

I use [Ghostty](https://ghostty.org) as my terminal - GPU-rendered, ligature support, and blazing fast.

---

## ✨ Features

- 🧩 **Plugin Manager**: [`lazy.nvim`](https://github.com/folke/lazy.nvim)
- 🧠 **LSP Support**: [`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig) + [`mason.nvim`](https://github.com/williamboman/mason.nvim)
- ✨ **Code Formatter**: [`conform.nvim`](https://github.com/stevearc/conform.nvim)
- 🌳 **Treesitter**: [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter)
- 🚀 **Completion**: [`blink.cmp`](https://github.com/saghen/blink.cmp) + snippets
- 📁 **File Explorer**: [`oil.nvim`](https://github.com/stevearc/oil.nvim)
- 🔍 **Fuzzy Finder**: [`fzf-lua`](https://github.com/ibhagwan/fzf-lua)
- 📊 **Status Line**: [`lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim)
- 📐 **Indent Detection**: [`guess-indent.nvim`](https://github.com/nmac427/guess-indent.nvim)
- 💬 **Startup Goodies**: [`snacks.nvim`](https://github.com/folke/snacks.nvim)
- 📌 **Navigation**: [`harpoon`](https://github.com/ThePrimeagen/harpoon)
- ⚡ **Motion & Navigation**: [`flash.nvim`](https://github.com/folke/flash.nvim)
- 🎨 **Themes**: Rose Pine & Catppuccin

---

## 📦 Requirements

> 💡 This setup uses [Homebrew](https://brew.sh) to install dependencies.

If you don't have Homebrew installed, run the command below:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

> 🔗 Visit [brew.sh](https://brew.sh) to check for the latest installation command if the one above doesn't work.


Install the following tools using Homebrew:

```bash
brew install fzf tmux neovim git node rust python lazygit starship
```


- [Homebrew (macOS)](https://brew.sh)
- [Neovim ≥ 0.10](https://neovim.io)
- [fzf](https://github.com/junegunn/fzf)
- [Rust](https://rustup.rs)
- [Node.js & npm](https://nodejs.org)
- [Python 3](https://www.python.org)
- [git](https://git-scm.com)
- [tmux](https://github.com/tmux/tmux)  
  ➕ Required for plugin support: [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm)
- [A Nerd Font](https://www.nerdfonts.com/font-downloads) (JetBrainsMono, Hack, etc.)
- For enhanced `z` + `cd` experience: [Zinit](https://github.com/zdharma-continuum/zinit)
- Recommended: [Lazygit](https://github.com/jesseduffield/lazygit)

---

### 🛠️ Setup Steps

## ⚙️ Setup

> Make sure to back up your existing configs before proceeding.

### 1. Backup existing configs

```bash
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.bak
```

### 2. Clone this repo

```bash
git clone https://github.com/johnpaulcas/dotfiles ~/.dotfiles
```

### 3. Create config folder

```bash
mkdir -p ~/.config
```

### 4. Symlink configs

```bash
# Neovim
ln -s ~/.dotfiles/.config/nvim ~/.config/nvim

# Ghostty
ln -s ~/.dotfiles/.config/ghostty ~/.config/ghostty

# Mouseless for mac
ln -s ~/.dotfiles/.config/mouseless/config.yaml ~/Library/Application\ Support/Mouseless/configs/config.yaml

# Tmux (optional)
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

# Zsh (optional)
ln -s ~/.dotfiles/.zshrc ~/.zshrc
```

> ⚠️ Make sure `~/.config/nvim` does not already exist before symlinking.

### 5. Launch Neovim

```bash
nvim
```

Neovim will install all plugins via `lazy.nvim` on first launch.

---

Install tmux/tpm

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

After installation enter to tmux mode by running

```bash
tmux
```

Reload TMUX environment so TPM is sourced:

```bash
tmux source ~/.tmux.conf
```

Press prefix + I (capital i, as in Install) to fetch the plugin

---

## 🖋 Fonts

Use any Nerd Font for icon support in Neovim, Tmux, and Zsh:

- [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads)
- FiraCode Nerd Font
- Hack Nerd Font

---

## 💡 Tips

- `:Lazy` — open the plugin manager
- `:Mason` — manage LSP servers and tools
- `:CheckHealth` — check system dependencies
- `<leader>ff` — fuzzy file finder
- Customize themes in `lazy.lua`

---

Happy Hacking 💻✨
