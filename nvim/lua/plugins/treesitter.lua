return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",

  config = function()
    require'nvim-treesitter.configs'.setup {
      ensure_installed = { "python", "lua", "vim"},
      auto_install = true,

      highlight = {
        enable = true,
      }
    }
  end,
}

