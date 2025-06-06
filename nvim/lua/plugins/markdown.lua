return {
  {
    event = "User FilePost",
    ft = "markdown", -- or 'event = "VeryLazy"'
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("render-markdown").setup({})
    end,
    keys = {
      { "<Leader>md", "<CMD>RenderMarkdown toggle<CR>", mode = { "n" }, desc = "markdown toggle preview" },
    },
  },
}
