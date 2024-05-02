return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "jay-babu/mason-null-ls.nvim",
  },
  ft = { "python", "vim", "lua", "javascript"},
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
        require("none-ls.diagnostics.flake8"),
        require("none-ls.diagnostics.eslint_d"),
      },
    })
  end,
}
