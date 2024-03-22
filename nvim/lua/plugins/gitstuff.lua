return {
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    config = function()
      require("gitsigns").setup()
    end,
    keys = {
      { "<Leader>gl", "<CMD>Gitsigns preview_hunk_inline<CR>", mode = { "n" }, desc = "gitsign preview" },
      { "<Leader>gn", "<CMD>Gitsigns next_hunk<CR>", mode = { "n" }, desc = "gitsign next_hunk" },
      { "<Leader>gp", "<CMD>Gitsigns prev_hunk<CR>", mode = { "n" }, desc = "gitsign prev_hunk" },
    },
  },
}
