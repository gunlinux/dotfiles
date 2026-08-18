-- Completion via blink.cmp (restored).
--
-- Provides LSP, path, snippet (friendly-snippets) and buffer completion,
-- plus signature help. Restored from the config that worked before the
-- built-in-completion rewrite. blink.cmp is pinned to v1.10.2 in
-- plugins.lua: setup() auto-downloads the CI-built fuzzy matcher, avoiding
-- the local cargo build that dyld rejects on macOS 27 (mis-aligned LINKEDIT).

local cmp = require('blink.cmp')
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
      -- Show the signature help automatically
      enabled = true,
      -- Show the signature help window after typing any of alphanumerics, `-` or `_`
      show_on_keyword = true,
      blocked_trigger_characters = {},
      blocked_retrigger_characters = {},
      -- Show the signature help window after typing a trigger character
      show_on_trigger_character = true,
      -- Show the signature help window when entering insert mode
      show_on_insert = true,
      -- Show the signature help window when the cursor comes after a trigger character when entering insert mode
      show_on_insert_on_trigger_character = true,
    },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})
