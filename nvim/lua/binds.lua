local function map(mode, combo, mapping, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, combo, mapping, options)
end
vim.g.mapleader = ' ' -- change the <leader> key to be comma

map('', '<F1>', '<Esc>') -- avoid opening help, treat it like escape (all modes)
map('', '<Up>', '<NOP>')
map('', '<Down>', '<NOP>')
map('', '<Left>', '<NOP>')
map('', '<Right>', '<NOP>')
map('', '<Ctrl>', '<Esc>')
map('n', '<Left>', ':bp<CR>', {noremap = true})
map('n', '<Right>', ':bn<CR>', {noremap = true})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>')

map('n', '<Leader><TAB>', ':NERDTreeToggle<CR>', {noremap = true})


--local builtin = require('telescope.builtin')
local dap = require('dap')
vim.keymap.set('n', '<Leader>ff', '<cmd>Telescope find_files<CR>', {noremap=true})
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {noremap=true})
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {noremap= true})
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {noremap = true})

vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, {noremap = true})
vim.keymap.set('n', '<F8>', dap.step_over, {noremap = true})
--vim.keymap.set('n', '<leader><C-F8>', dap.step_into(), {noremap = true})
vim.keymap.set('n', '<leader><F10>', dap.repl.open, {noremap = true})
vim.keymap.set('n', '<leader><F9>', dap.continue, {noremap = true})



--lua require'dap'.toggle_breakpoint()
--
--```
--:Telescope dap commands
--:Telescope dap configurations
--:Telescope dap list_breakpoints
--:Telescope dap variables
--:--Telescope dap frames
