-- lazy.nvim
return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  lazy = false,
  priority = 1000,
  opts = {
    dashboard = {
      -- your dashboard configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  }
}
