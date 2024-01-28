local function map(mode, combo, mapping, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, combo, mapping, options)
end
vim.g.mapleader = ' ' -- change the <leader> key to be comma

map('', '<F1>', '<Esc>') -- avoid opening help, treat it like escape (all modes)
map('', '<Ctrl>', '<Esc>')
map('n', '<Left>', ':bp<CR>', {noremap = true})
map('n', '<Right>', ':bn<CR>', {noremap = true})
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>')


--vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, {noremap = true})
--vim.keymap.set('n', '<F8>', dap.step_over, {noremap = true})
--vim.keymap.set('n', '<leader><C-F8>', dap.step_into(), {noremap = true})
--vim.keymap.set('n', '<leader><F10>', dap.repl.open, {noremap = true})
--vim.keymap.set('n', '<leader><F9>', dap.continue, {noremap = true})


--lua require'dap'.toggle_breakpoint()
--
--```
--:Telescope dap commands
--:Telescope dap configurations
--:Telescope dap list_breakpoints
--:Telescope dap variables
--:--Telescope dap frames
