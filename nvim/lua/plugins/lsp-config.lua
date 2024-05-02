return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "pyright",
        "gopls",
        "html",
        "cssls",
        'bashls',
        'jsonls',
        'yamlls',
        'eslint',
        },
      automatic_installation = true,
    })

    local mason_null_ls = require("mason-null-ls")
    local lspconfig = require("lspconfig")
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    lspconfig.lua_ls.setup({})
    lspconfig.pyright.setup({})
    lspconfig.gopls.setup({})
    lspconfig.eslint.setup({capabilities=capabilities})
    lspconfig.html.setup({})
    lspconfig.json.setup({})
    lspconfig.yaml.setup({})

    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "lsp go to documentation" })
    vim.keymap.set({ "n", "v" }, "<Leader>gf", vim.lsp.buf.format, { desc = "lsp format buffer" })
    vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, { desc = "lsp go to definition" })
    vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, { desc = "lsp conf action" })
    vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, { desc = "lsp go to references" })
    vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { desc = "lsp rename" })

    mason_null_ls.setup({
      ensure_installed = {
        "stylua",
        "black",
        "flake8",
        "isort",
        "eslint_d",
      },
    })
  end,
}
