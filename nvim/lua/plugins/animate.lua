return {
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.icons",
  },
  config = function()
    require("mini.animate").setup({
      scroll = {
        -- Whether to enable this animation
        enable = false,
      },
    })
  end,
}
