--  Помощь не нужна, никто не услышыт твой крик
vim.keymap.set({ "n", "v", "i" }, "<F1>", "<Nop>")

-- Переключение буферов через []
vim.keymap.set({ "n", "v" }, "<A-[>", "<cmd>bp<CR>")
vim.keymap.set({ "n", "v" }, "<A-]>", "<cmd>bn<CR>")

-- it's over it's a game over, man. This is game over
vim.keymap.set({ "n", "v", "i" }, "<Leader><F10>", "<cmd>qall!<CR>")

-- yank my buffer up
vim.keymap.set({ "v" }, "<Leader>y", '"+y')  -- E.g: <leader>yy will yank current line to os clipboard
vim.keymap.set({ "v" }, "<Leader>Y", '"+y$') -- E.g: <leader>yy will yank current line to os clipboard
vim.keymap.set({ "n" }, "<Leader>p", '"+p')  -- Paste after cursor from clipboard
vim.keymap.set({ "n" }, "<Leader>P", '"+P')  -- Paste before cursor from clipboard
