return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          --["<C-b>"] = cmp.mapping.scroll_docs(-4),
          --["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
	completion = {
	  autocomplete = false
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" , keyword_length =2},
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
