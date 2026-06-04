-- ── Dependencies (shared) ───────────────────────────────────────────────
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-neotest/nvim-nio",
})

-- ── Completion ──────────────────────────────────────────────────────────
vim.pack.add({ "https://github.com/rafamadriz/friendly-snippets" })
vim.pack.add({
  "https://github.com/saghen/blink.lib",
  "https://github.com/saghen/blink.cmp",
})

local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup({
  keymap = { preset = 'enter' },
  appearance = { nerd_font_variant = 'mono' },
  completion = {
    documentation = { auto_show = false, auto_show_delay_ms = 5000 },
    trigger = { prefetch_on_insert = false },
  },
  signature = {
    enabled = false,
    trigger = {
      enabled = false, -- if I uncomment this, the keymap won't work anymore
      show_on_trigger_character = false,
      show_on_insert_on_trigger_character = false,
    },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})

-- ── Colorscheme ─────────────────────────────────────────────────────────
vim.pack.add({ "https://github.com/craftzdog/solarized-osaka.nvim" })
require("solarized-osaka").setup({
  sidebars = { "vista_kind", "terminal", "packer" },
  styles = { sidebars = "transparent" },
  style = "dark",
  transparent = true,
})
vim.cmd [[colorscheme solarized-osaka]]

-- ── Status line ─────────────────────────────────────────────────────────
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
require("lualine").setup({
  options = { theme = 'solarized_dark' },
})

-- ── Buffer line ─────────────────────────────────────────────────────────
vim.pack.add({ "https://github.com/akinsho/bufferline.nvim" })
require("bufferline").setup{}

-- ── File tree ───────────────────────────────────────────────────────────
-- neo-tree v3.x branch; if vim.pack installs wrong version run :checkhealth neo-tree
vim.pack.add({ "https://github.com/nvim-neo-tree/neo-tree.nvim" })
require("neo-tree").setup({
  window = { position = "right" },
})
vim.keymap.set("n", "<Leader><Tab>", "<cmd>Neotree toggle<cr>", { desc = "Neotree" })

-- ── Git ─────────────────────────────────────────────────────────────────
vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/f-person/git-blame.nvim",
  "https://github.com/kdheepak/lazygit.nvim",
})

require("gitsigns").setup()
vim.keymap.set("n", "<Leader>gl", "<CMD>Gitsigns preview_hunk_inline<CR>", { desc = "gitsign preview" })
vim.keymap.set("n", "<Leader>gn", "<CMD>Gitsigns next_hunk<CR>", { desc = "gitsign next" })
vim.keymap.set("n", "<Leader>gp", "<CMD>Gitsigns prev_hunk<CR>", { desc = "gitsign prev" })

vim.cmd("highlight default link gitblame SpecialComment")
require("gitblame").setup({ enabled = false })
vim.keymap.set("n", "<Leader>gb", "<CMD>GitBlameToggle<CR>", { desc = "Git Blame Toggle" })

vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- ── Fuzzy finder ────────────────────────────────────────────────────────
vim.pack.add({ "https://github.com/nvim-telescope/telescope.nvim" })
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fx', builtin.diagnostics, { desc = 'Telescope diagnostics' })

-- ── Treesitter ──────────────────────────────────────────────────────────
-- Run :TSUpdate manually after first install
vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
})
require("treesitter-context").setup({
  enable = true,
  max_lines = 0,
  min_window_height = 1,
  line_numbers = true,
  multiline_threshold = 1,
  trim_scope = "outer",
  mode = "topline",
  separator = nil,
  zindex = 20,
})

-- ── Markdown ────────────────────────────────────────────────────────────
vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })
require("render-markdown").setup({})
vim.keymap.set("n", "<Leader>md", "<CMD>RenderMarkdown toggle<CR>", { desc = "markdown toggle preview" })

-- ── Dashboard ───────────────────────────────────────────────────────────
vim.pack.add({ "https://github.com/folke/snacks.nvim" })
require("snacks").setup({
  dashboard = {
    preset = {
      header = [[
   ███████╗  ██╗   ██╗███╗   ██╗██╗     ██╗███╗   ██╗██╗   ██╗██╗  ██╗
  ██╔════╝  ██║   ██║████╗  ██║██║     ██║████╗  ██║██║   ██║╚██╗██╔╝
  ██║  ███╗ ██║   ██║██╔██╗ ██║██║     ██║██╔██╗ ██║██║   ██║ ╚███╔╝
  ██║   ██║ ██║   ██║██║╚██╗██║██║     ██║██║╚██╗██║██║   ██║ ██╔██╗
  ╚██████╔╝ ╚██████╔╝██║ ╚████║███████╗██║██║ ╚████║╚██████╔╝██╔╝ ██╗
   ╚═════╝   ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝
      ]],
    },
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
      { section = "recent_files", padding = 1 },
    },
  },
})

-- ── Tmux navigation ─────────────────────────────────────────────────────
vim.pack.add({ "https://github.com/alexghergh/nvim-tmux-navigation" })
local nvim_tmux_nav = require('nvim-tmux-navigation')
nvim_tmux_nav.setup({ disable_when_zoomed = true })
vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

-- ── Multiple cursors ────────────────────────────────────────────────────
vim.pack.add({ "https://github.com/brenton-leighton/multiple-cursors.nvim" })
require("multiple-cursors").setup({})
vim.keymap.set({ "n", "i", "x" }, "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", { desc = "Add cursor down" })
vim.keymap.set({ "n", "i", "x" }, "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", { desc = "Add cursor up" })
vim.keymap.set({ "n", "i" }, "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", { desc = "Add/remove cursor" })

-- ── Zen mode ────────────────────────────────────────────────────────────
vim.pack.add({ "https://github.com/folke/zen-mode.nvim" })
require("zen-mode").setup({
  window = {
    backdrop = 1,
    width = 1,
    height = 1,
    options = {},
  },
  plugins = {
    options = {
      enabled = true,
      ruler = false,
      showcmd = false,
      laststatus = 0,
    },
    twilight = { enabled = true },
    gitsigns = { enabled = true },
    tmux = { enabled = true },
    todo = { enabled = false },
    alacritty = { enabled = true, font = "24" },
  },
})
vim.keymap.set("n", "<Leader>z", "<cmd>ZenMode<cr>", { desc = "Zen mode" })

-- ── Which-key ───────────────────────────────────────────────────────────
vim.pack.add({ "https://github.com/folke/which-key.nvim" })
require("which-key").setup({})
vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

-- ── Mason ───────────────────────────────────────────────────────────────
vim.pack.add({ "https://github.com/mason-org/mason.nvim" })
require("mason").setup({})

-- ── Neotest ─────────────────────────────────────────────────────────────
vim.pack.add({
  "https://github.com/antoinemadec/FixCursorHold.nvim",
  "https://github.com/nvim-neotest/neotest",
  "https://github.com/nvim-neotest/neotest-python",
})
require("neotest").setup({
  default_strategy = "dap",
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      args = { "--log-level", "DEBUG" },
      runner = "pytest",
    }),
  },
})
vim.keymap.set("n", "<leader>lt", "<CMD>Neotest summary<cr>", { desc = "neotest summary" })
vim.keymap.set("n", "<leader>lo", "<CMD>Neotest output-panel<cr>", { desc = "neotest output" })

-- ── DAP ─────────────────────────────────────────────────────────────────
vim.pack.add({
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/jay-babu/mason-nvim-dap.nvim",
  "https://github.com/theHamsta/nvim-dap-virtual-text",
  "https://github.com/igorlfs/nvim-dap-view",
})

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
  ensure_installed = { "python", "delve", "codelldb" },
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

dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      local cwd = vim.fn.getcwd()
      local bin_name = nil
      local cargo_toml = cwd .. "/Cargo.toml"
      if vim.fn.filereadable(cargo_toml) == 1 then
        for line in io.lines(cargo_toml) do
          local name = line:match('^name%s*=%s*["\'](.+)["\']')
          if name then bin_name = name; break end
        end
      end
      return cwd .. "/target/debug/" .. (bin_name or vim.fn.fnamemodify(cwd, ":t"))
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  }
}

dap.defaults.fallback.exception_breakpoints = { 'raised' }
dap.listeners.before.attach["dap-view-config"] = function()
  dv.open()
  dap.set_exception_breakpoints({ "Warning", "Error", "Exception" })
end
dap.listeners.before.launch["dap-view-config"] = function() dv.open() end
dap.listeners.before.event_terminated["dap-view-config"] = function() dv.close() end
dap.listeners.before.event_exited["dap-view-config"] = function() dv.close() end

vim.keymap.set({ "n", "v" }, "<Leader><F8>", "<CMD>DapToggleBreakpoint<CR>", { desc = "Toggle Breakpoint" })
vim.keymap.set({ "n", "v" }, "<F5>", "<CMD>DapContinue<CR>", { desc = "Dap Continue" })
vim.keymap.set({ "n", "v" }, "<F7>", "<CMD>DapStepInto<CR>", { desc = "Dap Step Into" })
vim.keymap.set({ "n", "v" }, "<F8>", "<CMD>DapStepOver<CR>", { desc = "Dap Step Over" })
vim.keymap.set({ "n", "v" }, "<F9>", "<CMD>DapStepOut<CR>", { desc = "Dap Step Out" })
vim.keymap.set("n", "<leader>da", function()
  dap.set_exception_breakpoints({ "Warning", "Error", "Exception" })
end, { desc = "Stop on exceptions" })
