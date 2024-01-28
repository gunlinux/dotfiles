local cmd = vim.cmd             -- execute Vim commands
local exec = vim.api.nvim_exec  -- execute Vimscript
local g = vim.g                 -- global variables
local opt = vim.opt             -- global/buffer/windows-scoped options
vim.g.nightflyTransparent = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '



require('plugins')
require('options')
require('binds')
require('coc')

-- after_party
--https://www.ricalo.com/blog/install-powerline-windows/#
--https://github.com/lsd-rs/lsd
--
--
--mkdir .virtualenvs
--cd .virtualenvs
--python -m venv debugpy
--debugpy/bin/python -m pip install debugpy
--
--debugpy/bin/python -m pip install debugpy
--
