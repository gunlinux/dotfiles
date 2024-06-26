return {
  {
    "mfussenegger/nvim-dap",
    ft = { "python", "go" },
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
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
      local dapui_config = {
        controls = {
          element = "repl",
          enabled = true,
          icons = {
            disconnect = "",
            pause = "",
            play = "",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = "",
          },
        },
        element_mappings = {},
        expand_lines = true,
        floating = {
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        force_buffers = true,
        icons = {
          collapsed = "",
          current_frame = "",
          expanded = "",
        },
        layouts = {
          {
            -- You can change the order of elements in the sidebar
            elements = {
              -- Provide IDs as strings or tables with "id" and "size" keys
              {
                id = "scopes",
                size = 0.25, -- Can be float or integer > 1
              },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks",      size = 0.25 },
              { id = "watches",     size = 0.25 },
            },
            size = 30,
            position = "left", -- Can be "left" or "right"
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 10,
            position = "bottom", -- Can be "bottom" or "top"
          },
        },
        mappings = {
          edit = "e",
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          repl = "r",
          toggle = "t",
        },
        render = {
          indent = 1,
          max_value_lines = 100,
        },
      }
      daptext.setup()
      dapui.setup(dapui_config)
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
    lazy = true,
    ft = "python",
    config = function()
      require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
    end,
  },
  {
    "leoluz/nvim-dap-go",
    lazy = true,
    ft = "go",
    config = function()
      local dap = require("dap")
      local go_conf = {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}",
      }
      dap.configurations.go = go_conf
      dap.adapters.go = function(callback, config)
        -- Wait for delve to start
        vim.defer_fn(function()
          callback({ type = "server", host = "127.0.0.1", port = "port" })
        end, 100)
      end
      require("dap-go").setup(go_conf)
    end,
  },
}
