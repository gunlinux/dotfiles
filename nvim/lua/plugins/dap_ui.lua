return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
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
        "<Leader><F5>",
        "<CMD>DapContinue<CR>",
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

