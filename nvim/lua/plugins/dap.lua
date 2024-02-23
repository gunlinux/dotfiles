return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap",
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      {
        "<Leader>b",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<F9>",
        function()
          require("dap").step_over()
        end,
        desc = "Step over",
      },
      {
        "<F8>",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },
      {
        "<Leader>ds",
        function()
          require("dapui").toggle()
        end,
        desc = "dap ui toggle",
      },
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Continue debug",
      },
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
        -- dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        -- dapui.close()
      end
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    lazy=true,
    config = function()
      require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
    end,
  },
}
