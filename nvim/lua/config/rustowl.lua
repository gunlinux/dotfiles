-- RustOwl: inline ownership/borrow visualization for Rust. It runs as its own
-- `rustowl` LSP client alongside rust-analyzer (the two don't conflict). The
-- server binary is not installed by vim.pack — run `cargo install rustowl`
-- once. Highlighting starts on LspAttach (auto_enable); otherwise use
-- :Rustowl enable / toggle. On save, ftplugin/rust.lua re-analyzes the buffer.

require("rustowl").setup({
  auto_attach = true,
  auto_enable = true,
  -- Hover delay before analysis runs; 500ms felt laggy while moving around.
  idle_time = 300,
  -- rustowl's defaults (#0000cc blue etc.) are near-invisible on a dark
  -- background; use the solarized-osaka accents instead.
  colors = {
    definitely_live = "#859900", -- green:  variable's lifetime
    maybe_initialized = "#2aa198", -- cyan:   maybe initialized
    imm_borrow = "#268bd2", -- blue:   immutable borrow
    mut_borrow = "#d33682", -- magenta: mutable borrow
    move = "#b58900", -- yellow: value moved
    call = "#cb4b16", -- orange: function call
    outlive = "#dc322f", -- red:    lifetime error
  },
  client = {
    on_attach = function(_, buffer)
      vim.keymap.set("n", "<leader>ro", function()
        require("rustowl").toggle(buffer)
      end, { buffer = buffer, desc = "RustOwl toggle" })
    end,
  },
})
