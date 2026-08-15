# nvim

Plugin-light Neovim config (previously `nvim_remote`; replaces the old
plugin-heavy config). Uses the **builtin plugin manager** (`vim.pack`,
Neovim 0.12+): plugins are declared with `vim.pack.add()` in
`lua/config/plugins.lua` and cloned on first launch — no external plugin
manager. Everything else that can be done with built-in Neovim features or
plain CLI tools is reimplemented here; the rest is dropped (see below).

Targets Neovim 0.12+ (uses `vim.lsp.config` / `vim.lsp.enable`).

## Usage

Symlink the config into place (config is self-contained):

```sh
ln -s "$HOME/dotfiles/nvim" "$HOME/.config/nvim"
```

Or point Neovim directly at it for one-off runs:

```sh
nvim -u ~/dotfiles/nvim/init.lua
```

## What's ported / reimplemented

Each plugin from the previous config is either reimplemented with built-in
features or restored via `vim.pack`:

| Original plugin       | Replacement                                            |
| --------------------- | ------------------------------------------------------ |
| options / keymaps     | kept verbatim (`lua/config/options.lua`, `keymaps.lua`) |
| LSP servers           | built-in `vim.lsp.config` + `lsp/*.lua`                |
| solarized-osaka.nvim  | manual port in `colors/solarized-osaka.lua`            |
| lualine.nvim          | custom `statusline.lua`                                 |
| bufferline.nvim       | custom `tabline.lua`                                    |
| blink.cmp             | built-in LSP autocompletion (`completion.lua`)          |
| neo-tree.nvim         | netrw (`explorer.lua`, `<Leader><Tab>`)                 |
| gitsigns.nvim         | sign column + hunk jumps via `git diff` (`git.lua`)     |
| git-blame.nvim        | `git blame` in a split (`git.lua`)                      |
| lazygit.nvim          | `:terminal lazygit` (`git.lua`)                         |
| telescope.nvim        | restored via `vim.pack`                                 |
| nvim-dap / dap-view / | restored via `vim.pack` (`dap.lua`; debuggers via mason) |
| mason-nvim-dap        |                                                        |
| nvim-tmux-navigation  | manual split/tmux dispatch (`tmux.lua`)                 |
| zen-mode.nvim         | option toggle (`ui.lua`, `<Leader>z`)                   |
| which-key.nvim        | keymap listing buffer (`ui.lua`, `<Leader>?`)           |
| neotest               | `:make` + quickfix (`ui.lua`, `<Leader>lt` / `<Leader>lo`) |
| venv-selector.nvim    | restored via `vim.pack` (`venv.lua`)                    |

## Dropped (not feasible without plugins)

- **noice.nvim** — cosmetic; messages/cmdline use defaults.
- **snacks.nvim dashboard** — a plain empty buffer on startup instead.
- **multiple-cursors.nvim** — no built-in equivalent.
- **render-markdown.nvim** — only a `conceallevel` tweak remains; rich
  rendering needs a plugin.
- **nvim-treesitter / treesitter-context** — built-in tree-sitter highlighting
  works, but there is no parser installer and no sticky-context feature.
- **mason.nvim (LSP)** — LSP binaries are expected on `$PATH` (same assumption
  the `lsp/*.lua` files already make); mason is used only to install DAP
  debuggers (see `dap.lua`).
- **friendly-snippets** — no built-in snippet engine.

## Dependencies on `$PATH`

- LSP servers: `gopls`, `pyright-langserver`, `lua-language-server`, `ruff`,
  `rust-analyzer`, `vscode-css-language-server`, `htmx-lsp`
- `fd`, `rg` (telescope file/grep sources)
- `git`, `lazygit` (optional, for `<Leader>lg`), `tmux` (optional)

DAP debuggers are **not** on `$PATH` — install them once via mason:
`:MasonInstall debugpy delve codelldb`.

## Plugin management

Plugins are managed by the builtin `vim.pack` (Neovim 0.12+). Missing plugins
are cloned automatically on first launch; state is tracked in
`nvim-pack-lock.json` (commit it). To update: `:lua vim.pack.update()` and
confirm with `:write`, then `:restart`.

Note: `vim.pack` tracks every plugin installed under
`~/.local/share/nvim/site/pack/core/opt/`. If you drop a plugin from
`plugins.lua`, remove its directory there (and its lock entry) too — otherwise
it stays installed and keeps being updated.

## Tree-sitter note

Highlighting uses Neovim's built-in tree-sitter, but parsers are **not**
auto-installed (no nvim-treesitter plugin). Any parser found under
`~/.local/share/nvim/parser/` is picked up automatically — e.g. built with a
`tree-sitter` CLI, or installed by another config sharing the same data dir.
Missing parsers fall back to regex highlighting.
