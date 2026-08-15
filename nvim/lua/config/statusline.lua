-- Custom statusline (replaces lualine.nvim).
--
-- Shows: mode · git branch · filename  —  diagnostics · filetype · line:col · %.
-- laststatus = 3 (set in options.lua) gives one global statusline.

local hl = {
  { "StMode", { fg = "#002c38", bg = "#268bd3", bold = true } },
  { "StModeInsert", { fg = "#001419", bg = "#849900", bold = true } },
  { "StModeVisual", { fg = "#001419", bg = "#d23681", bold = true } },
  { "StModeCommand", { fg = "#001419", bg = "#c94c16", bold = true } },
  { "StModeReplace", { fg = "#001419", bg = "#db302d", bold = true } },
  { "StModeTerminal", { fg = "#001419", bg = "#6d71c4", bold = true } },
  { "StFile", { fg = "#adb7b7", bg = "#002c38", bold = true } },
  { "StGit", { fg = "#6d71c4", bg = "#002c38" } },
  { "StDiagError", { fg = "#db302d", bg = "#002c38" } },
  { "StDiagWarn", { fg = "#b28500", bg = "#002c38" } },
  { "StFileType", { fg = "#9eabac", bg = "#002c38" } },
  { "StPos", { fg = "#9eabac", bg = "#002c38" } },
  { "StPct", { fg = "#576d74", bg = "#002c38" } },
}
for _, group in ipairs(hl) do
  vim.api.nvim_set_hl(0, group[1], group[2])
end

local mode_names = {
  n = "NORMAL",
  i = "INSERT",
  v = "VISUAL",
  V = "V-LINE",
  ["\22"] = "V-BLOCK",
  c = "COMMAND",
  R = "REPLACE",
  t = "TERMINAL",
}
local mode_hls = {
  n = "StMode",
  i = "StModeInsert",
  v = "StModeVisual",
  V = "StModeVisual",
  ["\22"] = "StModeVisual",
  c = "StModeCommand",
  R = "StModeReplace",
  t = "StModeTerminal",
}

-- Cached git branch per buffer (updated asynchronously, no per-redraw git call).
_G.git_branches = {}

local function update_branch(buf)
  local file = vim.api.nvim_buf_get_name(buf)
  if file == "" then
    _G.git_branches[buf] = ""
    return
  end
  local dir = vim.fn.fnamemodify(file, ":h")
  vim.system({ "git", "-C", dir, "branch", "--show-current" }, {}, function(out)
    _G.git_branches[buf] = out.code == 0 and vim.trim(out.stdout) or ""
  end)
end

vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged" }, {
  desc = "Refresh statusline git branch",
  callback = function()
    update_branch(vim.api.nvim_get_current_buf())
  end,
})

function _G.Statusline()
  local buf = vim.api.nvim_get_current_buf()
  local mode = vim.fn.mode()

  local file = vim.fn.expand("%:t")
  if file == "" then
    file = "[No Name]"
  end
  if vim.bo[buf].modified then
    file = file .. " ●"
  end
  if vim.bo[buf].readonly then
    file = file .. " 🔒"
  end

  local branch = _G.git_branches[buf] or ""

  local diag = vim.diagnostic.count(buf)
  local errs = diag[vim.diagnostic.severity.ERROR] or 0
  local warns = diag[vim.diagnostic.severity.WARN] or 0

  local ft = vim.bo[buf].filetype ~= "" and vim.bo[buf].filetype or "-"

  local left = table.concat({
    "%#" .. (mode_hls[mode] or "StMode") .. "# " .. (mode_names[mode] or mode:upper()) .. " ",
    "%#StGit# " .. (branch ~= "" and branch .. " " or ""),
    "%#StFile# " .. file .. " ",
  })
  local right = table.concat({
    " %#StDiagError#" .. errs .. "e",
    " %#StDiagWarn#" .. warns .. "w",
    " %#StFileType# " .. ft,
    " %#StPos# %l:%c",
    " %#StPct# %p%% ",
  })

  return left .. "%=" .. right
end

vim.opt.statusline = "%!v:lua.Statusline()"
