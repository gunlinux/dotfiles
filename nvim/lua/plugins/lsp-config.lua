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
      },
      automatic_installation = true,
    })

    local mason_null_ls = require("mason-null-ls")
    local lspconfig = require("lspconfig")
    lspconfig.lua_ls.setup({})
    lspconfig.pyright.setup({})

    vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
    vim.keymap.set("n", "<Leader>gf", vim.lsp.buf.format, {})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
    vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, {})

    mason_null_ls.setup({
      ensure_installed = {
        "stylua",
        "black",
        "flake8",
        "isort",
      },
    })
  end,
}
