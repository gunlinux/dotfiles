return {
  "gunlinux/solarized-osaka.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    styles = {
      sidebars = "transparent",
    }
  }
  ,
  config = function()
    require("solarized-osaka").setup({
      sidebars = { "qf", "vista_kind", "terminal", "packer" },
      style = "dark", -- "dark" or "light"
      transparent = true,
      styles = {
        sidebars = "transparent",
      }
    })
    --[[
    require('mini.animate').setup({
      open = { enable = false },
      close = { enable = false },
    })
    ]] --
    vim.cmd [[colorscheme solarized-osaka]]
  end,
}
