return {
  lazy = false,
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require('lualine').setup {
      options = { theme = 'solarized_dark' },
    }
  end
}
