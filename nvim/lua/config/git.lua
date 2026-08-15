-- Git helpers (replace gitsigns.nvim, git-blame.nvim and lazygit.nvim).
--
-- * Sign column shows add/change/delete hunks via `git diff HEAD`.
-- * <Leader>gn / <Leader>gp jump to the next/previous hunk.
-- * <Leader>gl opens the file diff in a split.
-- * <Leader>gb opens `git blame` in a split.
-- * <Leader>lg opens lazygit in a terminal (requires lazygit on PATH).

vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#849900" })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#b28500" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#db302d" })

vim.fn.sign_define("GitSignsAdd", { text = "▎", texthl = "GitSignsAdd" })
vim.fn.sign_define("GitSignsChange", { text = "▎", texthl = "GitSignsChange" })
vim.fn.sign_define("GitSignsDelete", { text = "▎", texthl = "GitSignsDelete" })

local SIGN_GROUP = "nvim_remote_git"

local function git_root(file)
  local dir = vim.fn.fnamemodify(file, ":h")
  local out = vim.fn.system({ "git", "-C", dir, "rev-parse", "--show-toplevel" })
  if vim.v.shell_error ~= 0 then
    return nil
  end
  return vim.trim(out)
end

local function place(name, buf, lnum)
  local total = vim.api.nvim_buf_line_count(buf)
  lnum = math.max(1, math.min(lnum, total))
  vim.fn.sign_place(0, SIGN_GROUP, name, buf, { lnum = lnum })
end

local function update(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  vim.fn.sign_unplace(SIGN_GROUP, { buffer = buf })

  local file = vim.api.nvim_buf_get_name(buf)
  if file == "" then
    return
  end
  local root = git_root(file)
  if not root then
    return
  end

  local rel = file:sub(#root + 2) -- strip "<root>/"
  local out = vim.fn.system({
    "git", "-C", root, "diff", "HEAD", "--unified=0", "--no-color", "--", rel,
  })
  if vim.v.shell_error ~= 0 then
    return
  end

  for line in out:gmatch("[^\n]+") do
    local old_start, old_count, new_start, new_count =
      line:match("^@@ %-(%d+),?(%d*) %+(%d+),?(%d*) @@")
    if old_start then
      old_start = tonumber(old_start)
      new_start = tonumber(new_start)
      old_count = tonumber(old_count ~= "" and old_count or "1")
      new_count = tonumber(new_count ~= "" and new_count or "1")

      if old_count == 0 then
        -- pure addition
        for ln = new_start, new_start + new_count - 1 do
          place("GitSignsAdd", buf, ln)
        end
      elseif new_count == 0 then
        -- pure deletion
        place("GitSignsDelete", buf, old_start)
      else
        -- modification
        for ln = new_start, new_start + new_count - 1 do
          place("GitSignsChange", buf, ln)
        end
      end
    end
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  desc = "Refresh git signs",
  callback = function(args)
    update(args.buf)
  end,
})

local function hunk_lines(buf)
  local placed = vim.fn.sign_getplaced(buf, { group = SIGN_GROUP })[1].signs or {}
  local lines = {}
  for _, s in ipairs(placed) do
    lines[#lines + 1] = s.lnum
  end
  table.sort(lines)
  return lines
end

local function goto_hunk(forward)
  local buf = vim.api.nvim_get_current_buf()
  local cur = vim.fn.line(".")
  local lines = hunk_lines(buf)
  if #lines == 0 then
    return
  end

  if forward then
    for _, ln in ipairs(lines) do
      if ln > cur then
        vim.fn.cursor(ln, 1)
        return
      end
    end
    vim.fn.cursor(lines[1], 1)
  else
    for i = #lines, 1, -1 do
      if lines[i] < cur then
        vim.fn.cursor(lines[i], 1)
        return
      end
    end
    vim.fn.cursor(lines[#lines], 1)
  end
end

local function diff_split()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    return
  end
  local root = git_root(file)
  if not root then
    return
  end
  local rel = file:sub(#root + 2)
  local out = vim.fn.system({ "git", "-C", root, "diff", "HEAD", "--no-color", "--", rel })

  vim.cmd("vsplit | enew")
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(out, "\n"))
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].filetype = "diff"
  vim.bo[buf].modifiable = false
end

local function blame_split()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    return
  end
  local root = git_root(file)
  if not root then
    return
  end
  local rel = file:sub(#root + 2)
  local out = vim.fn.system({ "git", "-C", root, "blame", "--", rel })

  vim.cmd("vsplit | enew")
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(out, "\n"))
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].modifiable = false
end

vim.keymap.set("n", "<Leader>gl", diff_split, { desc = "git diff preview" })
vim.keymap.set("n", "<Leader>gn", function() goto_hunk(true) end, { desc = "git next hunk" })
vim.keymap.set("n", "<Leader>gp", function() goto_hunk(false) end, { desc = "git prev hunk" })
vim.keymap.set("n", "<Leader>gb", blame_split, { desc = "git blame" })
vim.keymap.set("n", "<Leader>lg", function()
  vim.cmd("botright 18new | terminal lazygit")
end, { desc = "lazygit" })
