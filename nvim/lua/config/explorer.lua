-- File tree (replaces neo-tree.nvim) using Neovim's built-in netrw.
--
-- <Leader><Tab> toggles the explorer sidebar (split right, matching the old
-- neo-tree window position = "right").

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3 -- tree view
vim.g.netrw_browse_split = 4 -- open file in the previous window
vim.g.netrw_altv = 1 -- explorer splits right
vim.g.netrw_winsize = 30

vim.keymap.set("n", "<Leader><Tab>", "<cmd>Lexplore<cr>", { desc = "Toggle file explorer" })
