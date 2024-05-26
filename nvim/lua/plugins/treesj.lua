 return {
  'Wansmer/treesj',
  keys = { '<Leader>m', '<Leader>j', '<Leader>s' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup({--[[ your config ]]})
  end,
}
