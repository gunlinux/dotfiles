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

-- ── Completion (blink.cmp) ────────────────────────────────────────────────
-- Setup lives in config/completion.lua.
vim.pack.add({ "https://github.com/rafamadriz/friendly-snippets" })
vim.pack.add({
  "https://github.com/saghen/blink.lib",
  -- Pinned: cargo build on macOS 27 produces a dylib dyld rejects
  -- (mis-aligned LINKEDIT), so completion.lua uses the CI-built prebuilt
  -- from this release tag instead. Bump when the linker issue is fixed.
  { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
})

-- ── File tree (neo-tree.nvim) ────────────────────────────────────────────
-- Setup lives in config/explorer.lua. neo-tree v3.x requires nui + nvim-nio.
vim.pack.add({
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/nvim-neo-tree/neo-tree.nvim",
})

-- ── Keymap hints (which-key.nvim) ───────────────────────────────────────
-- Setup lives in config/ui.lua.
vim.pack.add({ "https://github.com/folke/which-key.nvim" })

-- ── Fuzzy finder (telescope.nvim) ───────────────────────────────────────
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fx', builtin.diagnostics, { desc = 'Telescope diagnostics' })
