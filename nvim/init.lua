vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  defaults = {
    lazy = true, },
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  rocks = {
    enabled = false,
  },
  checker = { enabled = false, notify = false },
  install = {}, --colorscheme = { "NeoSolarized" } },
})

require("config.options")
require("config.keymaps")
require("config.lsp")
