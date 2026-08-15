-- Builtin plugin manager: vim.pack (Neovim 0.12+). Plugins are cloned on
-- first launch and usable right after add(); update with vim.pack.update().
-- State is tracked in nvim-pack-lock.json next to init.lua.

vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-telescope/telescope.nvim",
})

-- ── DAP ──────────────────────────────────────────────────────────────────
-- mason is used only to install debuggers (debugpy/delve/codelldb), not LSP
-- servers. Setup lives in config/dap.lua.
vim.pack.add({
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/jay-babu/mason-nvim-dap.nvim",
  "https://github.com/theHamsta/nvim-dap-virtual-text",
  "https://github.com/igorlfs/nvim-dap-view",
  "https://github.com/mason-org/mason.nvim",
})

-- ── venv-selector ─────────────────────────────────────────────────────────
-- Setup lives in config/venv.lua.
vim.pack.add({ "https://github.com/linux-cultist/venv-selector.nvim" })

-- ── Fuzzy finder (telescope.nvim) ───────────────────────────────────────
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fx', builtin.diagnostics, { desc = 'Telescope diagnostics' })
