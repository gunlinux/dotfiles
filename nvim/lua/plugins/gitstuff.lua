return {
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    config = function()
      require("gitsigns").setup()
    end,
    keys = {
      { "<Leader>gl", "<CMD>Gitsigns preview_hunk_inline<CR>", mode = { "n" }, desc = "gitsign preview" },
    },
  },
}
