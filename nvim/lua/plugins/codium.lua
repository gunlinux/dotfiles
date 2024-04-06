return {
  {
    'Exafunction/codeium.vim',
      config = function ()
        vim.keymap.set('i', '<F1>', function  () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
        vim.keymap.set('i', '<Leader>;', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
        vim.keymap.set('i', '<Leader>,', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
        vim.keymap.set('i', '<Leader>x', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
  end
  },
}

