return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "pyright",
        "ruff",
        },
      automatic_installation = true,
    })

    local lspconfig = require("lspconfig")

    lspconfig.lua_ls.setup({})
    lspconfig.pyright.setup({
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
    vim.keymap.set({ "n", "v" }, "<Leader>gf", vim.lsp.buf.format, { desc = "lsp format buffer" })
    vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, { desc = "lsp go to definition" })
    vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, { desc = "lsp conf action" })
    vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, { desc = "lsp go to references" })
    vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { desc = "lsp rename" })

    end,
}
