return {
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("solarized-osaka").setup({
      sidebars = { "vista_kind", "terminal", "packer" },
      styles = {
        sidebars = "transparent",
      },
      style = "dark",
      transparent = true,
    })
    vim.cmd [[colorscheme solarized-osaka]]
  end,
}
