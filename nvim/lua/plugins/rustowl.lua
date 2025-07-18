return {
  {
    'cordx56/rustowl',
    version = '*', -- Latest stable version
    build = "cargo install rustowl",
    lazy = false,
    config = function()
      require("rustowl").setup({
        auto_enable = true,
      })
    end,
  }
}
