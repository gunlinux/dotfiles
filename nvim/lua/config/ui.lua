-- Misc UI: zen mode, keymap viewer and a test runner (replace zen-mode.nvim,
-- which-key.nvim and neotest respectively).

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

-- ── Keymap viewer (which-key replacement) ────────────────────────────────
vim.keymap.set("n", "<leader>?", function()
  local maps = {}
  for _, m in ipairs(vim.api.nvim_get_keymap("n")) do
    if m.lhs:sub(1, 1) == " " then
      maps[#maps + 1] = string.format("  %-12s %s", m.lhs:sub(2), m.desc or "")
    end
  end
  table.sort(maps)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, "[keymaps]")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Keymaps (leader)", "" })
  vim.api.nvim_buf_set_lines(buf, 2, -1, false, maps)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].modifiable = false
  vim.keymap.set("n", "q", function()
    vim.cmd("bwipeout!")
  end, { buffer = buf })

  vim.cmd("botright 12new | buffer " .. buf)
end, { desc = "show keymaps" })

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
