vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.plugins")

-- colorscheme first: :colorscheme resets 'laststatus', so options.lua must run
-- after it to re-apply laststatus = 3 (same ordering as the original config).
require("config.colorscheme")
require("config.options")
require("config.keymaps")
require("config.statusline")
require("config.tabline")
require("config.completion")
require("config.explorer")
require("config.git")
require("config.tmux")
require("config.ui")
require("config.dap")
require("config.venv")
require("config.lsp")
