return {
  "folke/which-key.nvim",
  lazy = false,
  dependencies = {
    "echasnovski/mini.icons",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    triggers = {
      { "<leader>", mode = { "n", "v" } },
    },
  },
  config = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>f",     desc = "telescope", group = "telescope" },
      { "<leader>m",     desc = "markdown",  group = "markdown" },
      { "<leader><tab>", desc = "neotree" },
      { "<leader>c",     desc = "code",      group = "code" },
      { "<leader>?",     desc = "which-key" },
      -- hide telescope find
      { "<leader>x",     hidden = true },
      { "<leader>f1",    hidden = true },
      { "<leader><F10>", hidden = true },
      { "<leader>P",     hidden = true },
      { "<leader>p",     hidden = true },
    })
  end,

  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "which-key",
    },
  },
}
