return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      integrations = {
        lsp_trouble = true,
      }
    })
    vim.cmd([[colorscheme catppuccin-mocha]])
  end,
}
