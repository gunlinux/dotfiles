#!/bin/sh

# bash

ln -s ~/dotfiles/bash_aliases ~/.bash_aliases
cp -f ~/dotfiles/bashrc ~/.bashrc

# git
ln -s gitconfig ~/.gitconfig
ln -s gitignore_global ~/.gitignore_global

# stuff
mkdir -p ~/.config
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/editorconfig ~/.editorconfig
ln -s ~/dotfiles/wezterm.lua ~/.wezterm.lua
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/gitconfig ~/.gitconfig


# tmux tpm manage
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

if [ "$EUID" -eq 0 ] ; then
  prefix=''
else
  prefix='sudo'
fi

# install deps
if [ -z "$DOCKER" ] && [ -f /etc/debian_version ]; then
  $prefix apt install -y ripgrep tmux fd-find
fi

# deps for arch
if [ -z "$DOCKER" ] && [ -f /etc/arch-release ]; then
  echo "i use arch btw"
  # tree-sitter-cli: nvim-treesitter `main` compiles parsers with it (below).
  # lazygit: backs lazygit.nvim / <Leader>lg.
  $prefix pacman -S ripgrep eza tmux tree-sitter-cli lazygit
fi

# Plugins are managed by vim.pack (see nvim/lua/config/plugins.lua).
# vim.pack.add() clones any missing plugins synchronously on first launch,
# and blink.cmp builds its fuzzy lib via pwait(), so one headless run installs all.
nvim --headless "+qa"
# Treesitter parsers: nvim-treesitter `main` installs asynchronously, so a bare
# "+TSUpdate" "+qa" quits before anything compiles. install():wait() blocks until
# every parser is built (needs the tree-sitter CLI + a C compiler on PATH).
nvim --headless "+lua require('nvim-treesitter').install({ \
  'lua', 'vim', 'vimdoc', 'bash', 'json', 'toml', 'yaml', 'html', 'css', \
  'go', 'gomod', 'gosum', 'python', 'rust', 'markdown', 'markdown_inline', \
}):wait(600000)" "+qa"
# The lsp/*.lua configs launch bare server binaries; install them via Mason
# (it prepends its bin/ to nvim's PATH so the bare cmd configs resolve). Bundled
# with the DAP tools: mason-nvim-dap's ensure_installed runs async after UIEnter
# and won't finish in a plain "+qa" run, whereas :MasonInstall blocks until done.
nvim --headless "+MasonInstall \
  gopls pyright ruff lua-language-server rust-analyzer css-lsp htmx-lsp \
  debugpy delve codelldb" "+qall"
~/.tmux/plugins/tpm/bin/install_plugins
