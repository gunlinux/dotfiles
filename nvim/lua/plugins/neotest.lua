return {
  {
    "nvim-neotest/neotest",
    event = "User FilePost",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    config = function()
      require("neotest").setup({
        default_strategy = "dap",
        adapters = {
          require("neotest-python")({
            dap = {
              justMyCode = false,
              --console = "integratedTerminal",
            },
            args = { "--log-level", "DEBUG" },
            runner = "pytest",
          }),
        },
      })
    end,
    keys = {
      {
        "<leader>lt",
        "<CMD>Neotest summary<cr>",
        desc = "open neotest summary window",
      },
      {
        "<leader>lo",
        "<CMD>Neotest output-panel<cr>",
        desc = "open neotest summary window",
      },
    },
  },
}
