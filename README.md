# Dotfiles

🎯 My personal minimal Neovim setup powered by [`lazy.nvim`](https://github.com/folke/lazy.nvim).

It comes with everything I need out of the box: LSP 🧠, fuzzy finding 🔍, formatting ✨, autocompletion 🚀, and themes 🎨 that actually make editing feel good.

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
- 🎨 **Themes**: Rose Pine & Catppuccin

---

## ⚙️ [Installation](#%ef%b8%8f-installation)

### 📦 [Prerequisites](#%f0%9f%93%a6-prerequisites)

- [Neovim >= 0.10](https://neovim.io)
- [git](https://git-scm.com)
- [Homebrew (macOS)](https://brew.sh)
- [Node/npm](https://nodejs.org)
- [Rust (via rustup)](https://rustup.rs)
- [Python 3](https://www.python.org)
- [A Nerd Font (JetBrainsMono, Hack, etc.)](https://www.nerdfonts.com/font-downloads)
- [tmux](https://github.com/tmux/tmux) + [TPM](https://github.com/tmux-plugins/tpm)
- [fzf](https://github.com/junegunn/fzf)

```bash
brew install fzf
$(brew --prefix)/opt/fzf/install  # optional fuzzy key bindings
```

### 🛠️ Setup Steps

1. **Backup your existing config**

   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. **Create the config directory**

   ```bash
   mkdir -p ~/.config
   ```

3. **Clone the dotfiles repo**

   ```bash
   git clone https://github.com/yourname/dotfiles ~/.dotfiles
   ```

4. **Check that the config exists**

   ```bash
   ls ~/.dotfiles/.config/nvim
   ```

5. **Symlink Neovim config**

   ```bash
   ln -s ~/.dotfiles/.config/nvim ~/.config/nvim
   ```

6. **Open Neovim to install plugins**

   ```bash
   nvim
   ```

> ⚠️ Make sure `~/.config/nvim` is not a real folder before symlinking. Remove or move it first.

---

## 🧩 Plugin Dependencies (via Mason)

Run `:Mason` inside Neovim to manage tools.

Install the following:

- Lua: `stylua`
- Python: `black`, `isort`, `pylint`
- JS/TS: `prettierd`, `prettier`
- Rust: `rust-analyzer`, `rustfmt`
- Markdown: `marksman`

---

## 🎛️ Keybindings

| Key          | Action                   |
| ------------ | ------------------------ |
| `<leader>a`  | ➕ Harpoon: Add file      |
| `<C-e>`      | 📋 Harpoon: Toggle menu  |
| `<leader>ff` | 🔍 FZF: Find files       |
| `<leader>fg` | 🔎 FZF: Live grep        |
| `<leader>cf` | ✨ Format code (Conform)  |
| `<leader>nh` | ❌ Clear search highlight |
| `lg`         | 🐞 Show diagnostics      |
| `-`          | 📁 Open parent dir (Oil) |

LSP-specific bindings like rename, code actions, and navigation are attached per buffer.

---

## 🌳 Treesitter Languages

```
c, lua, vim, elixir, heex, javascript, typescript, tsx, html, css,
yaml, markdown, markdown_inline, json, dockerfile, solidity, rust,
python, bash, gitignore, prisma, query
```

---

## 🖋 Recommended Fonts

Use any Nerd Font for icon support:

- [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads)
- FiraCode Nerd Font
- Hack Nerd Font

---

## 💡 Notes

- Themes are controlled in `lazy.lua`
- Use `:Mason` to install missing tools
- `blink.cmp` benefits from Rust nightly if building from source
- Install [TPM](https://github.com/tmux-plugins/tpm) for tmux theming support

---

Happy Hacking ✨
