-- Plugins

local Plug = vim.fn['plug#']

vim.call('plug#begin')

--Plug NerdTREE
Plug('scrooloose/nerdtree', {on = 'NERDTreeToggle'})
Plug('Xuyuanp/nerdtree-git-plugin')

--Formating
Plug('editorconfig/editorconfig-vim')

-- Git
Plug('airblade/vim-gitgutter')

--- Python ---
Plug('neoclide/coc.nvim', {branch = 'release'})
Plug('mfussenegger/nvim-dap')
Plug('mfussenegger/nvim-dap-python')
Plug('nvim-telescope/telescope-dap.nvim')
Plug('rcarriga/nvim-dap-ui')


Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { tag= '0.1.2' })

--- Gui ---

Plug('nvim-lualine/lualine.nvim')
Plug('nvim-tree/nvim-web-devicons')

Plug('akinsho/bufferline.nvim')
-- Plug('shaunsingh/solarized.nvim')

Plug('bluz71/vim-nightfly-colors', { as= 'nightfly'})

vim.call('plug#end')



require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
require('telescope').load_extension('dap')

require("dapui").setup()
