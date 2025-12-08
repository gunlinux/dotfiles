return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  lazy = false, -- neo-tree will lazily load itself
  config = function() 
    vim.opt.termguicolors = true
    require("bufferline").setup{}
  end,
  keys = {
    { "<Leader><Left>", "<cmd>bp<cr>", desc = "prev buffer" },
    { "<Leader><Right>", "<cmd>bp<cr>", desc = "next buffer" },
  },
}
