return {
  {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'mfussenegger/nvim-dap',
    "theHamsta/nvim-dap-virtual-text",
  },
  keys  = {
    { "<Leader>b",  function() require("dap").toggle_breakpoint() end, desc = "Stop" },
    { "<Leader>N", function() require("dap").step_over() end, desc = "Stop" },
    { "<Leader>n", function() require("dap").step_into() end, desc = "Stop" },
    { "<Leader>D", function() require("dap").continue() end },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local daptext = require("nvim-dap-virtual-text")

    daptext.setup()
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end
  },
  {
    'mfussenegger/nvim-dap-python',
    ft = "python",
    dependencies = {
      'mfussenegger/nvim-dap'
    },
    config = function()
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    end,
  },
}

