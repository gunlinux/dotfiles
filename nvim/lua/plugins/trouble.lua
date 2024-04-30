return {
  "folke/trouble.nvim",
  branch = "dev",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
      { "<Leader>xx", "<CMD>Trouble diagnostics toggle<CR>",  mode = { "n", "v" }, desc = "Telescope find file" },
  },
 opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
