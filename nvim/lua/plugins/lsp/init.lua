return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
  },
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "pyright",
        "ruff",
        "gopls",
        "jsonls",
        "bashls",
      },
      automatic_installation = true,
    })

    local lspconfig = require("lspconfig")
    local servers = require("plugins.lsp.lsp_servers")
    for name, opts in pairs(servers) do
      --opts.on_init = configs.on_init
      --opts.on_attach = require("lsp_signature").on_attach
      opts.capabilities = capabilities

      lspconfig[name].setup(opts)
    end

    vim.keymap.set({ "n", "v" }, "grf", vim.lsp.buf.format, { desc = "lsp format buffer" })
    vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "lsp go to definition" })
  end,
}
