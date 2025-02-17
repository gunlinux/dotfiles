return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "jay-babu/mason-nvim-dap.nvim",
    "mfussenegger/nvim-dap",
    "saghen/blink.cmp",
  },
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "pyright",
        "ruff",
        "gopls",
        },
      automatic_installation = true,
    })

    local python_path = table.concat({ vim.fn.stdpath('data'),  'mason', 'packages', 'debugpy', 'venv', 'bin', 'python'}, '/'):gsub('//+', '/')
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
            require('mason-nvim-dap').default_setup(config) -- don't forget this!
        end,
      },
    })

    local lspconfig = require("lspconfig")

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {
              'vim',
              'require'
            },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    })
    lspconfig.gopls.setup({
      capabilities = capabilities,
    })
    lspconfig.pyright.setup({
      capabilities = capabilities,
      settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              -- Ignore all files for analysis to exclusively use Ruff for linting
              ignore = { '*' },
            },
          },
        },
    })
    lspconfig.ruff.setup({
      trace = 'messages',
      init_options = {
        settings = {
          logLevel = 'debug',
        }
      }
    })

    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "lsp go to documentation" })
    vim.keymap.set({ "n", "v" }, "<Leader>cf", vim.lsp.buf.format, { desc = "lsp format buffer" })
    vim.keymap.set("n", "<Leader>cd", vim.lsp.buf.definition, { desc = "lsp go to definition" })
    vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, { desc = "lsp conf action" })
    vim.keymap.set("n", "<Leader>cr", vim.lsp.buf.references, { desc = "lsp go to references" })
    vim.keymap.set("n", "<Leader>cn", vim.lsp.buf.rename, { desc = "lsp rename" })

  end,
}
