return {
  {

    "tadmccorkle/markdown.nvim",
    ft = "markdown", -- or 'event = "VeryLazy"'
    keys = {
      { "<Leader>mo", "<CMD>MDListItemBelow<CR>", mode = { "n", "i" }, desc = "markdown list below" },
      { "<Leader>mO", "<CMD>MDListItemAbove<CR>", mode = { "n", "i" }, desc = "markdown list below" },
      { "<Leader>mt", "<CMD>MDTaskToggle<CR>", mode = { "n", "i" }, desc = "markdown task toggle" },
    },
    opts = {
      -- configuration here or empty for defaults
    },
  },
  {
    "ellisonleao/glow.nvim",
    ft = "markdown",
    config = true,
    cmd = "Glow",
    keys = {
      { "<Leader>mp", "<CMD>Glow<CR>", mode = { "n" }, desc = "markdown preview" },
    },
  },
  {
    'MeanderingProgrammer/markdown.nvim',
    name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('render-markdown').setup({})
    end,
    keys = {
      { "<Leader>md", "<CMD>RenderMarkdownToggle<CR>", mode = { "n" }, desc = "markdown toggle preview" },
    },
  }
}
