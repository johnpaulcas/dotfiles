# ⌨️ IntelliJ / Android Studio Vim Mappings

Cheat sheet for [`.ideavimrc`](../.ideavimrc). Open it from the IDE with `<Space>?`.

Leader = `Space`. The keys follow the Neovim config, so they work the same in both editors.

## 🔍 Find

| Keys | Action | Neovim equivalent |
| --- | --- | --- |
| `<leader>ff` | Go to file | fzf files |
| `<leader>fg` / `<leader>fw` | Find in path | live grep |
| `<leader>fr` | Recent files | — |
| `<leader>fb` | Search IDE actions | fzf builtin |
| `<leader><leader>` | Switch between open files | fzf buffers |
| `<leader>/` | Find in current file | grep current buffer |

## 🧭 Code navigation

| Keys | Action | Neovim equivalent |
| --- | --- | --- |
| `gd` / `gD` | Go to definition | LSP definition / declaration |
| `gi` | Go to implementation | LSP implementation |
| `gr` | Find usages | LSP references |
| `gt` | Go to type | LSP type definition |
| `gO` | File structure | document symbols |
| `gW` | Workspace symbols | workspace symbols |
| `K` | Quick documentation | hover |
| `<C-o>` / `<C-i>` | Jump back / forward (across files) | jumplist |

## 🛠️ Code actions

| Keys | Action | Neovim equivalent |
| --- | --- | --- |
| `ga` | Code actions (Alt+Enter) | code action |
| `<leader>rn` | Rename | LSP rename |
| `<leader>cf` | Reformat code | conform |
| `<leader>th` | Toggle inlay hints | inlay hints |

## 🚨 Errors

| Keys | Action | Neovim equivalent |
| --- | --- | --- |
| `lg` | Show error description | diagnostic float |
| `]d` / `[d` | Next / previous error | diagnostics |

## 📁 Files & bookmarks

| Keys | Action | Neovim equivalent |
| --- | --- | --- |
| `-` | Reveal file in project view | oil |
| `<leader>e` | Toggle NERDTree | — |
| `<leader>a` | Toggle bookmark | harpoon add |
| `<C-e>` | Show bookmarks | harpoon menu |

## ▶️ Run & debug

| Keys | Action |
| --- | --- |
| `<leader>rr` | Run |
| `<leader>rd` | Debug |
| `<leader>db` | Toggle breakpoint |

## 🪟 Windows

| Keys | Action |
| --- | --- |
| `<leader>sv` / `<leader>sh` | Split vertical / horizontal |
| `<leader>sx` | Close split |
| `<C-h/j/k/l>` | Move between splits |
| `<leader>z` | Distraction-free mode |

## ⚙️ Config

| Keys | Action |
| --- | --- |
| `<leader>vr` | Reload `.ideavimrc` |
| `<leader>?` | Open this cheat sheet |
| `<Esc>` / `<leader>h` | Clear search highlight |

## ✂️ Editing plugins (built in)

| Keys | Action | Plugin |
| --- | --- | --- |
| `gcc` / `gc` + motion | Comment line / selection | commentary |
| `ysiw"` | Wrap word in quotes | surround |
| `cs"'` | Change `"` to `'` | surround |
| `ds"` | Delete surrounding quotes | surround |
| `cia` / `daa` | Change / delete a function argument | argtextobj |
| `yie` / `vae` | Yank / select the whole file | textobj-entire |
| `cx` + motion (twice) | Swap two pieces of text | exchange |

## 💡 Tips

- To map a new IDE feature, find its action ID with `:actionlist <keyword>`, or turn on *Help → Find Action → "Track Action Ids"*. Then add `nnoremap <keys> :action <ActionId><CR>` to `.ideavimrc`, and add a row here.
- If an IDE shortcut clashes with Vim (for example `Ctrl+D`), choose who handles it under *Settings → Editor → Vim → Shortcuts*.
- `:nmap <leader>` lists every Space mapping inside the IDE.
