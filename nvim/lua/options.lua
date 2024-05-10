vim.opt.hidden = true

vim.opt.showcmd = true
vim.opt.nu = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.laststatus = 2
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.g.editorconfig = true

-- transparent
vim.api.nvim_command("highlight Normal guibg=none")
vim.api.nvim_command("highlight NonText guibg=none")
vim.api.nvim_command("highlight LineNr guibg=none")
vim.api.nvim_command("highlight CursorLineNr guibg=none")
vim.api.nvim_command("highlight BufferLineFill guibg=none")
vim.api.nvim_command("highlight SignColumn guibg=none")

vim.api.nvim_command("highlight BufferCurrentMod guibg=none")
vim.api.nvim_command("highlight BufferCurrentSign guibg=none")
vim.api.nvim_command("highlight BufferCurrentTarget guibg=none")
vim.api.nvim_command("highlight BufferCurrentIndex guibg=none")
vim.api.nvim_command("highlight BufferCurrent guibg=none")
vim.g.nightflyTransparent = true
vim.g.termguicolors = true
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.opt.termguicolors = true --  24-bit RGB colors

-- backgu
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 700

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

-- spaces
vim.opt.list = true
vim.opt.listchars="tab:»·,trail:·,nbsp:·"

vim.g.mapleader = " "

--  Помощь не нужна
vim.keymap.set({ "n", "v", "i" }, "<F1>", "<Nop>")

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>")
-- Переключение буферов через стрелочки
vim.keymap.set({ "n", "v" }, "<c-Left>", ":bp<CR>")
vim.keymap.set({ "n", "v" }, "<c-Right>", ":bn<CR>")
-- it's over it's a game over, man. This is game over
vim.keymap.set({ "n", "v", "i" }, "<leader><F10>", ":qall!<CR>")

-- yank my buffer up
vim.keymap.set({ "v" }, "<leader>y", '"+y')  -- E.g: <leader>yy will yank current line to os clipboard
vim.keymap.set({ "v" }, "<leader>Y", '"+y$') -- E.g: <leader>yy will yank current line to os clipboard
vim.keymap.set({ "n" }, "<leader>p", '"+p')  -- Paste after cursor from clipboard
vim.keymap.set({ "n" }, "<leader>P", '"+P')  -- Paste before cursor from clipboard
