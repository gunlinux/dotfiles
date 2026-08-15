-- Custom tabline (replaces bufferline.nvim).
--
-- Lists all listed, named buffers with their buffer number for `:b N`,
-- highlights the current one, and marks modified buffers. Buffer switching is
-- already bound in keymaps.lua to <Leader><Left>/<Leader><Right> (bp/bn).

vim.api.nvim_set_hl(0, "TabLineBuf", { fg = "#9eabac", bg = "#063540" })
vim.api.nvim_set_hl(0, "TabLineBufSel", { fg = "#b28500", bg = "#001419", bold = true })
vim.api.nvim_set_hl(0, "TabLineBufMod", { fg = "#c94c16", bg = "#063540", bold = true })
vim.api.nvim_set_hl(0, "TabLineBufModSel", { fg = "#c94c16", bg = "#001419", bold = true })

function _G.Tabline()
  local current = vim.api.nvim_get_current_buf()
  local bufs = {}
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[b].buflisted and vim.api.nvim_buf_get_name(b) ~= "" then
      bufs[#bufs + 1] = b
    end
  end

  local parts = {}
  for _, b in ipairs(bufs) do
    local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(b), ":t")
    local modified = vim.bo[b].modified
    local hl
    if b == current then
      hl = modified and "TabLineBufModSel" or "TabLineBufSel"
    else
      hl = modified and "TabLineBufMod" or "TabLineBuf"
    end
    parts[#parts + 1] = string.format("%%#%s# %d:%s%s ", hl, b, name, modified and "●" or "")
  end

  return table.concat(parts) .. "%#TabLineFill#"
end

vim.opt.tabline = "%!v:lua.Tabline()"
vim.opt.showtabline = 2
