 return {
  'Wansmer/treesj',
  ft = { "python", "go" , "javascript" },
  keys = { '<Leader>m', '<Leader>j', '<Leader>s' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup({--[[ your config ]]})
  end,
}
