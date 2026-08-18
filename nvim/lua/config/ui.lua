-- Misc UI: zen mode, keymap hints (which-key.nvim) and a test runner
-- (replace zen-mode.nvim and neotest respectively).

-- ── Zen mode ─────────────────────────────────────────────────────────────
local zen_saved = nil

local function toggle_zen()
  local opts = { "number", "relativenumber", "signcolumn", "cursorline", "laststatus", "showcmd", "ruler" }
  if zen_saved then
    for o, v in pairs(zen_saved) do
      vim.opt[o] = v
    end
    zen_saved = nil
  else
    zen_saved = {}
    local targets = {
      number = false,
      relativenumber = false,
      signcolumn = "no",
      cursorline = false,
      laststatus = 0,
      showcmd = false,
      ruler = false,
    }
    for _, o in ipairs(opts) do
      zen_saved[o] = vim.opt[o]:get()
      vim.opt[o] = targets[o]
    end
  end
end

vim.keymap.set("n", "<Leader>z", toggle_zen, { desc = "zen mode" })

-- ── Keymap hints (which-key.nvim) ───────────────────────────────────────
require("which-key").setup({})
vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

-- ── Test runner (neotest replacement) ────────────────────────────────────
-- Runs pytest on the current file via :make, filling the quickfix list.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function(args)
    vim.bo[args.buf].makeprg = "pytest -q --tb=short"
  end,
})
vim.keymap.set("n", "<leader>lt", "<cmd>make %<cr>", { desc = "run pytest on file" })
vim.keymap.set("n", "<leader>lo", "<cmd>copen<cr>", { desc = "open test output (quickfix)" })

-- ── Markdown conceal (small render-markdown stand-in) ────────────────────
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.wo.conceallevel = 2
  end,
})
