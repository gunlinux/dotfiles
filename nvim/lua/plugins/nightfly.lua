return {
  "bluz71/vim-nightfly-colors",
  name = "nightfly",
  lazy = false,
  priority = 1000,
  config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme nightfly]])
      vim.cmd [[do ColorScheme]]
	end,
}
