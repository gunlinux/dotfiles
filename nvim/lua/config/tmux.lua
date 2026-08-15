-- Tmux navigation (replaces nvim-tmux-navigation).
--
-- <C-h/j/k/l> move between vim splits; when there is no split in that
-- direction the keypress is forwarded to tmux. <C-\> = last pane/window,
-- <C-Space> = next tmux window. No-ops when not running inside tmux.

local function in_tmux()
  return vim.env.TMUX ~= nil and vim.env.TMUX ~= ""
end

local tmux_dir = { h = "L", j = "D", k = "U", l = "R" }

local function navigate(dir)
  local cur = vim.api.nvim_get_current_win()
  pcall(vim.cmd, "wincmd " .. dir)
  if vim.api.nvim_get_current_win() == cur and in_tmux() then
    vim.fn.system({ "tmux", "select-pane", "-" .. tmux_dir[dir] })
  end
end

vim.keymap.set("n", "<C-h>", function() navigate("h") end, { desc = "navigate left (vim/tmux)" })
vim.keymap.set("n", "<C-j>", function() navigate("j") end, { desc = "navigate down (vim/tmux)" })
vim.keymap.set("n", "<C-k>", function() navigate("k") end, { desc = "navigate up (vim/tmux)" })
vim.keymap.set("n", "<C-l>", function() navigate("l") end, { desc = "navigate right (vim/tmux)" })

vim.keymap.set("n", "<C-\\>", function()
  if in_tmux() then
    vim.fn.system({ "tmux", "select-pane", "-l" })
  else
    vim.cmd("wincmd p")
  end
end, { desc = "last active (vim/tmux)" })

vim.keymap.set("n", "<C-Space>", function()
  if in_tmux() then
    vim.fn.system({ "tmux", "next-window" })
  end
end, { desc = "next tmux window" })
