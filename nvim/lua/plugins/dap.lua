return { {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap",
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap-python",
      "leoluz/nvim-dap-go",
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
            elements = {
              {
                id = "scopes",
                size = 0.30,
              },
              {
                id = "breakpoints",
                size = 0.30,
              },
              {
                id = "console",
                size = 0.30,
              },
            },
            position = "left",
            size = 30,
          },
          {
            elements = {

              {
                id = "repl",
                size = 1,
              },
            },
            position = "bottom",
            size = 15,
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
    config = function()
      require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
    end,
  },
  {
    "leoluz/nvim-dap-go",
    lazy = true,
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
  }
}
