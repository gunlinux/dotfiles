return {
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require("solarized-osaka").setup({
      style = "dark", -- "dark" or "light"
      transparent = true,
    })
    --[[
    require('mini.animate').setup({
      open = { enable = false },
      close = { enable = false },
    })
    ]]--
    vim.cmd[[colorscheme solarized-osaka]]
  end,
}
