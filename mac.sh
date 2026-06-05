brew install coreutils starship neovim

brew install ripgrep fzf git jq lua-language-server

# vscode-css-language-server (and html/json) live in this formula; nvim/lsp/css_lsp.lua
# launches the bare `vscode-css-language-server` cmd, so it must be on PATH.
brew install vscode-langservers-extracted

# htmx-lsp has no brew formula; it's a Rust crate. nvim/lsp/htmx.lua launches the
# bare `htmx-lsp` cmd, so install it via cargo (needs rust/cargo on PATH).
cargo install htmx-lsp

# tree-sitter CLI: nvim-treesitter's `main` branch shells out to it to compile
# parsers (go.sh's install step needs it). lazygit backs lazygit.nvim / <Leader>lg.
brew install tree-sitter lazygit


defaults write -g NSWindowShouldDragOnGesture -bool true


