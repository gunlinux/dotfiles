return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
    "ray-x/lsp_signature.nvim",
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

    local lspconfig = require("lspconfig")
    local servers = require("lsp_servers")
    for name, opts in pairs(servers) do
      --opts.on_init = configs.on_init
      opts.on_attach = require "lsp_signature".on_attach
      opts.capabilities = capabilities

      lspconfig[name].setup(opts)
    end

    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "lsp go to documentation" })
    vim.keymap.set({ "n", "v" }, "<Leader>cf", vim.lsp.buf.format, { desc = "lsp format buffer" })
    vim.keymap.set("n", "<Leader>cd", vim.lsp.buf.definition, { desc = "lsp go to definition" })
    vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, { desc = "lsp conf action" })
    vim.keymap.set("n", "<Leader>cr", vim.lsp.buf.references, { desc = "lsp go to references" })
    vim.keymap.set("n", "<Leader>cn", vim.lsp.buf.rename, { desc = "lsp rename" })
  end,
}
