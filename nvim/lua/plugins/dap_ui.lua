return {
  {
    event = "VeryLazy",
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      local python_path = table.concat(
      { vim.fn.stdpath('data'), 'mason', 'packages', 'debugpy', 'venv', 'bin', 'python' }, '/'):gsub('//+', '/')
      require('mason-nvim-dap').setup({
        ensure_installed = { "python", "delve" },
        handlers = {
          function(config)
            -- Keep original functionality
            require('mason-nvim-dap').default_setup(config)
          end,

          python = function(config)
            config.adapters = {
              type = "executable",
              command = python_path,
              args = {
                "-m",
                "debugpy.adapter",
              },
            }
            require('mason-nvim-dap').default_setup(config)   -- don't forget this!
          end,
        },
      })
    end,
  },
  {
    event = "VeryLazy",
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      require("dapui").setup()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
    -- dap binds
    keys = {
      {
        "<Leader><F8>",
        "<CMD>DapToggleBreakpoint<CR>",
        mode = { "n", "v" },
        desc = "Toggle Breakpoint"
      },
      {
        "<F5>",
        "<CMD>DapContinue<CR>",
        mode = { "n", "v" },
        desc = "Dap Continue"
      },
      {
        "<F7>",
        "<CMD>DapStepInto<CR>",
        mode = { "n", "v" },
        desc = "Dap Continue"
      },
      {
        "<F8>",
        "<CMD>DapStepInto<CR>",
        mode = { "n", "v" },
        desc = "Dap Continue"
      },
      {
        "<F9>",
        "<CMD>DapStepOver<CR>",
        mode = { "n", "v" },
        desc = "Dap Continue"
      },
    },
  }
}
