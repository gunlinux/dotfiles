return {
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
}

}
