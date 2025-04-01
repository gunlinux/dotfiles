return {
  lazy = false,
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "craftzdog/solarized-osaka.nvim",
  },
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = 'solarized-osaka'
      },
    })
  end,
}
