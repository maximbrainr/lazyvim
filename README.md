# 💤 LazyVim — Maxim's Config

My personal [LazyVim](https://github.com/LazyVim/LazyVim) configuration.
Refer to the [LazyVim documentation](https://lazyvim.github.io/installation) for the base setup.

`<leader>` is the **Space** key.

## 🎨 Colorscheme

[**Catppuccin**](https://github.com/catppuccin/nvim) with the **Mocha** flavour.

- The default `tokyonight` theme is disabled.
- Available flavours (change in `lua/plugins/colorschema.lua`): `latte`, `frappe`, `macchiato`, `mocha`.

## ⌨️ Custom Keymaps

These are on top of the [default LazyVim keymaps](https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua).

| Mode | Keymap | Action |
| ---- | ------ | ------ |
| `n` | `<leader>1` … `<leader>9` | Jump directly to buffer/tab 1–9 in the bufferline |
| `n` | `<leader>bd` | Delete the current buffer while keeping the window layout (moves to the next listed buffer instead of the file explorer) |
| `n` | `<leader>yp` | Yank the current file's **absolute** path to the system clipboard |
| `n` | `<leader>yr` | Yank the current file's **relative** path to the system clipboard |

### Command-line tweaks

- `:bd` (and `:Bd`) are remapped to the smart buffer-delete above, so closing a buffer preserves your split layout.

## ⚙️ Options

Defined in `lua/config/options.lua`:

- **`whichwrap`** extended with `h,l,<,>,[,]` — `h`/`l`, the arrow keys, and `<BS>`/`<Space>` wrap to the previous/next line at line ends.

## 🧹 Formatting

Configured via [conform.nvim](https://github.com/stevearc/conform.nvim) in `lua/plugins/formatting.lua`:

- For `javascript`, `typescript`, `javascriptreact`, and `typescriptreact`, formatters run as `prettier` → `eslint_d` (in that order).
- `eslint_d` runs **last** so ESLint rules win (e.g. single quotes), preventing Prettier from re-adding double quotes.

## 🚀 Installation on another machine

Install [Neovim](https://neovim.io/), then clone this repo into your config location:

```bash
# Linux / macOS
git clone https://github.com/maximbrainr/lazyvim.git ~/.config/nvim
```

```powershell
# Windows
git clone https://github.com/maximbrainr/lazyvim.git $env:LOCALAPPDATA\nvim
```

Launch `nvim` — plugins install automatically from the pinned versions in `lazy-lock.json`.
