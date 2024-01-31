local cmd = vim.cmd             -- execute Vim commands
local exec = vim.api.nvim_exec  -- execute Vimscript
local g = vim.g                 -- global variables
local opt = vim.opt             -- global/buffer/windows-scoped options
vim.g.nightflyTransparent = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" if not vim.loop.fs_stat(lazypath) then vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")


require('options')
-- require('coc')

-- after_party
--https://www.ricalo.com/blog/install-powerline-windows/#
--https://github.com/lsd-rs/lsd
--
--
--mkdir ~/.virtualenvs
--cd ~/.virtualenvs
--python3 -m venv debugpy
--./debugpy/bin/python -m pip install debugpy
