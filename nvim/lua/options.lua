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
vim.api.nvim_command('highlight Normal guibg=none')
vim.api.nvim_command('highlight NonText guibg=none')
vim.api.nvim_command('highlight LineNr guibg=none')
vim.api.nvim_command('highlight CursorLineNr guibg=none')
vim.api.nvim_command('highlight BufferLineFill guibg=none')
vim.api.nvim_command('highlight SignColumn guibg=none')

vim.api.nvim_command('highlight BufferCurrentMod guibg=none')
vim.api.nvim_command('highlight BufferCurrentSign guibg=none')
vim.api.nvim_command('highlight BufferCurrentTarget guibg=none')
vim.api.nvim_command('highlight BufferCurrentIndex guibg=none')
vim.api.nvim_command('highlight BufferCurrent guibg=none')
vim.g.nightflyTransparent = true
vim.g.termguicolors = true
vim.opt.termguicolors = true      --  24-bit RGB colors


-- backgu 
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

local function map(mode, combo, mapping, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, combo, mapping, options)
end
vim.g.mapleader = " "

vim.keymap.set({"n"}, "<F6>", ":split | terminal env python3 %<CR>", { noremap = true})
vim.keymap.set({"n"}, "<F7>", ":bd!<CR>", { noremap = true})
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>")
-- Переключение буферов через стрелочки
vim.keymap.set({ "n", "v" }, "<c-Left>", ":bp<CR>")
vim.keymap.set({ "n", "v" }, "<c-Right>", ":bn<CR>")

