return {
  event = { "BufReadPost", "BufNewFile" },
  "mfussenegger/nvim-dap",
  dependencies = {
    "williamboman/mason.nvim",
    "nvim-neotest/nvim-nio",
    "jay-babu/mason-nvim-dap.nvim",
    "theHamsta/nvim-dap-virtual-text",
    { "igorlfs/nvim-dap-view", opts = {} },
  },
  config = function()
    local python_path = table
        .concat({ vim.fn.stdpath("data"), "mason", "packages", "debugpy", "venv", "bin", "python" }, "/")
        :gsub("//+", "/")
    local codelldb_path = table
      .concat({ vim.fn.stdpath("data"), "mason", "packages", "codelldb", "extension", "adapter", "codelldb" }, "/")
      :gsub("//+", "/")
    require("mason-nvim-dap").setup({
      ensure_installed = { "python", "delve", "codelldb" },
      automatic_setup = true,
      handlers = {
        function(config)
          -- Keep original functionality
          require("mason-nvim-dap").default_setup(config)
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
          require("mason-nvim-dap").default_setup(config) -- don't forget this!
        end,
        },
    })
    require("nvim-dap-virtual-text").setup({})
    local dap, dv = require("dap"), require("dap-view")
    dap.configurations.rust= {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          local cwd = vim.fn.getcwd()
          local cargo_toml = cwd .. "/Cargo.toml"
          local bin_name = nil

          if vim.fn.filereadable(cargo_toml) == 1 then
            for line in io.lines(cargo_toml) do
              local name = line:match('^name%s*=%s*["\'](.+)["\']')
              if name then
                bin_name = name
                break
              end
            end
          end

          if not bin_name then
            bin_name = vim.fn.fnamemodify(cwd, ":t")
          end

          return cwd .. "/target/debug/" .. bin_name
        end,
        --program = function()
         -- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        --end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false
      }
    }
    dap.listeners.before.attach["dap-view-config"] = function()
        dv.open()
    end
    dap.listeners.before.launch["dap-view-config"] = function()
        dv.open()
    end
    dap.listeners.before.event_terminated["dap-view-config"] = function()
        dv.close()
    end
    dap.listeners.before.event_exited["dap-view-config"] = function()
        dv.close()
    end
  end,
  -- dap binds
  keys = {
    {
      "<Leader><F8>",
      "<CMD>DapToggleBreakpoint<CR>",
      mode = { "n", "v" },
      desc = "Toggle Breakpoint",
    },
    {
      "<F5>",
      "<CMD>DapContinue<CR>",
      mode = { "n", "v" },
      desc = "Dap Continue",
    },
    {
      "<F7>",
      "<CMD>DapStepInto<CR>",
      mode = { "n", "v" },
      desc = "Dap Continue",
    },
    {
      "<F8>",
      "<CMD>DapStepInto<CR>",
      mode = { "n", "v" },
      desc = "Dap Continue",
    },
    {
      "<F9>",
      "<CMD>DapStepOver<CR>",
      mode = { "n", "v" },
      desc = "Dap Continue",
    },
  },
}
