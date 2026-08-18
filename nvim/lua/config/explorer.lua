-- File tree via neo-tree.nvim (restored; replaced the netrw explorer).
--
-- <Leader><Tab> toggles the explorer sidebar on the right (matching the old
-- neo-tree window position).

require("neo-tree").setup({
  window = { position = "right" },
})

vim.keymap.set("n", "<Leader><Tab>", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })
