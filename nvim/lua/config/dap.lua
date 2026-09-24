-- DAP (nvim-dap + dap-view + mason-nvim-dap), ported from the original nvim
-- config. Debuggers are installed once via mason: `:MasonInstall debugpy
-- delve codelldb`. LSP servers stay on $PATH (not mason-managed).

require("mason").setup({})

require("nvim-dap-virtual-text").setup({ virt_text_pos = 'eol' })

require("dap-view").setup({
  windows = {
    position = "below",
    terminal = { hide = { "delve" } },
  },
  winbar = {
    show = true,
    sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl" },
    default_section = "exceptions",
  },
})

local python_path = table
    .concat({ vim.fn.stdpath("data"), "mason", "packages", "debugpy", "venv", "bin", "python" }, "/")
    :gsub("//+", "/")

require("mason-nvim-dap").setup({
  -- ensure_installed is intentionally empty: it auto-installs async on UIEnter
  -- and races with an explicit blocking ":MasonInstall debugpy delve codelldb".
  -- The loser throws "Package is already installing", which derails the whole
  -- install and leaves the mason dir half-populated. Install deterministically
  -- with :MasonInstall instead.
  ensure_installed = {},
  automatic_setup = true,
  handlers = {
    function(config)
      require("mason-nvim-dap").default_setup(config)
    end,
    python = function(config)
      config.adapters = {
        type = "executable",
        command = python_path,
        args = { "-m", "debugpy.adapter" },
      }
      require("mason-nvim-dap").default_setup(config)
    end,
  },
})

local dap = require("dap")
local dv = require("dap-view")

-- Rust debugging uses lldb-dap, not codelldb. codelldb is unusable on this
-- machine (macOS 27 / arm64): its bundled lldb (21.1.7-codelldb) dies with
-- SIGILL the instant it tries to launch a process, so every session ended
-- immediately with "Debug adapter disconnected" and no output. Reproduce with
--   <mason>/codelldb/extension/lldb/bin/lldb --batch -o run -o quit /bin/echo
-- Homebrew LLVM's toolchain works, and lldb-dap is keg-only, hence the search.
local function find_lldb_dap()
  local candidates = {
    vim.fn.exepath("lldb-dap"),
    "/opt/homebrew/opt/llvm/bin/lldb-dap",
    "/usr/local/opt/llvm/bin/lldb-dap",
  }
  for _, path in ipairs(candidates) do
    if path ~= "" and vim.fn.executable(path) == 1 then
      return path
    end
  end
end

local lldb_dap = find_lldb_dap()
if lldb_dap then
  dap.adapters.lldb = {
    type = "executable",
    command = lldb_dap,
    name = "lldb",
    -- lldb-dap starts fast; the generous timeout only keeps a slow cold start
    -- from tripping nvim-dap's "Debug adapter didn't respond" watchdog.
    options = { initialize_timeout_sec = 20 },
  }
end

-- Resolves the executable to debug from the current Rust buffer:
--   * crate (Cargo.toml in cwd) -> `cargo build`, then target/debug/<name>
--   * bare .rs file (no Cargo.toml) -> `rustc -g` into a temp file
-- The build runs here rather than in a keymap so bare <F5> works too, and so a
-- stale binary can't be launched after an edit.
local function rust_program()
  local cwd = vim.fn.getcwd()
  local cargo_toml = cwd .. "/Cargo.toml"
  if vim.fn.filereadable(cargo_toml) == 1 then
    local build = vim.system({ "cargo", "build" }, { text = true }):wait()
    if build.code ~= 0 then
      error("cargo build failed:\n" .. (build.stderr or ""))
    end
    local bin_name = nil
    for line in io.lines(cargo_toml) do
      local name = line:match('^name%s*=%s*["\'](.+)["\']')
      if name then
        bin_name = name; break
      end
    end
    return cwd .. "/target/debug/" .. (bin_name or vim.fn.fnamemodify(cwd, ":t"))
  end
  local src = vim.api.nvim_buf_get_name(0)
  if src == "" or vim.fn.filereadable(src) == 0 then
    error("rust: no source file in the current buffer")
  end
  local out = vim.fn.tempname()
  local build = vim.system({ "rustc", "-g", "-o", out, src }, { text = true }):wait()
  if build.code ~= 0 then
    error("rustc failed:\n" .. (build.stderr or ""))
  end
  return out
end

dap.configurations.rust = {
  {
    name = "Launch file",
    type = "lldb",
    request = "launch",
    program = rust_program,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    -- Default "internalConsole" sends the program's stdout as DAP output events,
    -- which land in dap-view's REPL section — gone as soon as the session ends
    -- (dap-view closes on terminate), so a clean run showed no output at all.
    -- "integratedTerminal" runs the program in a terminal buffer that outlives
    -- the session.
    console = "integratedTerminal",
  }
}

-- venv-selector is restored (config/venv.lua); use its active venv, same as
-- the original config.
local function python()
  return require("venv-selector").python() or vim.fn.exepath('python3') or 'python3'
end

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch current file',
    program = '${file}',
    pythonPath = python,
    console = 'integratedTerminal',
  },
  {
    type = 'python',
    request = 'launch',
    name = 'Launch with arguments',
    program = '${file}',
    args = function()
      local args_string = vim.fn.input('Arguments: ')
      return vim.split(args_string, " ", true)
    end,
    pythonPath = python,
    console = 'integratedTerminal',
  },
  {
    type = 'python',
    request = 'launch',
    name = 'Run pytest',
    module = 'pytest',
    args = { '${file}' },
    pythonPath = python,
    console = 'integratedTerminal',
  },
}

-- Finds a normal editor window (non-sidebar, editable buffer) and focuses it.
-- Needed before dap-view opens (so it splits below the main editor, not a panel)
-- and before DAP jumps to source (so the file doesn't open inside a panel).
local function is_normal_win(win)
  local buf = vim.api.nvim_win_get_buf(win)
  return not vim.wo[win].winfixbuf
      and vim.bo[buf].buftype == ''
      and not vim.bo[buf].filetype:match('^neotest')
end

local function focus_normal_win()
  if is_normal_win(vim.api.nvim_get_current_win()) then return end
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if is_normal_win(win) then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
  vim.wo[vim.api.nvim_get_current_win()].winfixbuf = false
end

dap.listeners.before.event_stopped["fix_winfixbuf"] = focus_normal_win
dap.listeners.before.attach["dap-view-config"] = function()
  focus_normal_win()
  dv.open()
end
dap.listeners.before.launch["dap-view-config"] = function()
  focus_normal_win()
  dv.open()
end
-- dap-view owns exception breakpoints via state.exceptions_options.
-- Its after.initialize listener populates that state; ours runs after (registered later)
-- and forces the three filters on. dap-view's after.configurationDone then applies it.
dap.listeners.after.initialize["exception-breakpoints-auto"] = function(session)
  local dv_state = require("dap-view.state")
  local target = { raised = true, uncaught = true, userUnhandled = true }
  local opts = dv_state.exceptions_options[session.config.type]
  if opts then
    for _, opt in ipairs(opts) do
      if target[opt.exception_filter.filter] then
        opt.enabled = true
      end
    end
  end
end
dap.listeners.before.event_terminated["dap-view-config"] = function() dv.close() end
dap.listeners.before.event_exited["dap-view-config"] = function() dv.close() end

vim.keymap.set({ "n", "v" }, "<Leader><F8>", "<CMD>DapToggleBreakpoint<CR>", { desc = "Toggle Breakpoint" })
vim.keymap.set({ "n", "v" }, "<F5>", "<CMD>DapContinue<CR>", { desc = "Dap Continue" })
vim.keymap.set({ "n", "v" }, "<Leader><F5>", "<CMD>DapContinue<CR>", { desc = "Debug file" })
vim.keymap.set({ "n", "v" }, "<F7>", "<CMD>DapStepInto<CR>", { desc = "Dap Step Into" })
vim.keymap.set({ "n", "v" }, "<F8>", "<CMD>DapStepOver<CR>", { desc = "Dap Step Over" })
vim.keymap.set({ "n", "v" }, "<F9>", "<CMD>DapStepOut<CR>", { desc = "Dap Step Out" })
vim.keymap.set("n", "<leader>da", function()
  dap.set_exception_breakpoints({ "raised", "uncaught" })
end, { desc = "Stop on exceptions" })
