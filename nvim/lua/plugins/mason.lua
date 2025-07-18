return {
  {
    "mason-org/mason.nvim",
    opts = {},
    lazy = false,
    config = function()
      require("mason").setup()
    end
  }
}
