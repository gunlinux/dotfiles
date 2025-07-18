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

-- backup
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

vim.g.termguicolors = true
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
-- command autocomplete
vim.g.wildmenu = true
vim.opt.listchars = "tab:»·,trail:·,nbsp:·"
vim.diagnostic.config({ virtual_text = true})

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3


vim.lsp.set_log_level("debug")
