return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup()
  end,
  keys = {
    { "<Leader>b", "<CMD>BufferLinePick<CR>", mode = { "n" }, desc = "bufferline pick" },
  },
}
