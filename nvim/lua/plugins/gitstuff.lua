return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("gitsigns").setup()
    end,
    keys = {
      { "<Leader>gl", "<CMD>Gitsigns preview_hunk_inline<CR>", mode = { "n" }, desc = "gitsign preview" },
      { "<Leader>gn", "<CMD>Gitsigns next_hunk<CR>",           mode = { "n" }, desc = "gitsign next_hunk" },
      { "<Leader>gp", "<CMD>Gitsigns prev_hunk<CR>",           mode = { "n" }, desc = "gitsign prev_hunk" },
    },
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd("highlight default link gitblame SpecialComment")
      require("gitblame").setup({ enabled = false })
    end,
    keys = {
      {
        "<Leader>gb",
        "<CMD>GitBlameToggle<CR>",
        mode = { "n" },
        desc = "Git Blame Toggle",
      },
    },
  },
}
