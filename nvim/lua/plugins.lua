-- Plugins
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" if not vim.loop.fs_stat(lazypath) then vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = 'Neotree',
    keys = {
      {"<Leader><Tab>", "<CMD>Neotree toggle<CR>", mode = { "n", "i", "v" } }
  	},
  },

  -- dev
  'airblade/vim-gitgutter',
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "python", "lua", "vim","query" },
        auto_install = true,

        highlight = {
          enable = true,
        }
      }
    end,
  },
  -- python
  {'neoclide/coc.nvim', branch = 'release'},

  {
    'mfussenegger/nvim-dap',
    keys  = {
      { "<Leader>b",  function() require("dap").toggle_breakpoint() end, desc = "Stop" },
      { "<F8>", function() require("dap").step_over() end, desc = "Stop" },
      { "<Leader><F8>", function() require("dap").step_into() end, desc = "Stop" },
      { "<Leader><F10>", function() require("dap").repl.open() end},
      { "<Leader><F9>", function() require("dap").continue() end, desc = "Stop" },
    }
  },
  {
    'mfussenegger/nvim-dap-python',
    dependencies = {
      'mfussenegger/nvim-dap'
    },
    config = function()
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    end,
  },
  {
    'nvim-telescope/telescope-dap.nvim',
    dependencies = {
	    'nvim-telescope/telescope.nvim', 
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('telescope').load_extension('dap')
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap'
    },
    config = function()
      require("dapui").setup()
    end,

  },


  -- ui
  {
    'akinsho/bufferline.nvim',
    version = "*",
    lazy = false,
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup()
    end,
    keys = {
      { "<Leader>bl", "<CMD>BufferLinePick<CR>", mode = { "n", "i", "v" } },
    }
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
  	  'bluz71/vim-nightfly-colors',
    },
    config = function()
      require('lualine').setup{
        options = {
        	icons_enabled = true,
        	theme = 'nightfly'
      	}
      }
    end,
  },
  {
  	"bluz71/vim-nightfly-colors",
  	name = "nightfly",
  	lazy = false,
  	priority = 1000,
  	config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme nightfly]])
      vim.cmd [[do ColorScheme]]
	end,
  },
  -- fuzzy
  { 
	  'nvim-telescope/telescope.nvim', 
	  tag = '0.1.2' ,
    dependencies = "nvim-lua/plenary.nvim",
    cmd = "Telescope",
  	lazy = false,
    keys = {
            { "<Leader><Leader>", ":Telescope<CR>", mode = { "n", "i", "v" } },
            { "<Leader>ff", "<CMD>Telescope find_files<CR>", mode = { "n", "i", "v" } },
            { "<Leader>fg", "<CMD>Telescope live_grep<CR>", mode = { "n", "i", "v" } },
            { "<Leader>fc", "<CMD>Telescope commands<CR>", mode = { "n", "i", "v" } },
            { "<Leader>fk", "<CMD>Telescope keymaps<CR>", mode = { "n", "i", "v" } },
            { "<Leader>fb", "<CMD>Telescope buffers<CR>", mode = { "n", "i", "v" } },
        },
        config = true 
  },
}
require("lazy").setup(plugins)



-- keymaps 
--

--lua require'dap'.toggle_breakpoint()
--
--```
--:Telescope dap commands
--:Telescope dap configurations
--:Telescope dap list_breakpoints
--:Telescope dap variables
--:--Telescope dap frames
