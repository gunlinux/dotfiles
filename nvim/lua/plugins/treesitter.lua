return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "python",
        "lua",
        "vim",
        "bash",
        "markdown",
        "markdown_inline",
        "vimdoc",
        "regex",
      },

      auto_install = true,

      highlight = {
        enable = true,
      },
    })
  end,
}
