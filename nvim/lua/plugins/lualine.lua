return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    --"bluz71/vim-nightfly-colors",
  },
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "solarized_dark",
      },
    })
  end,
}
