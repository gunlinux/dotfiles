-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set("n", "<Leader>gd", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    vim.keymap.set("n", "<Leader>gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    vim.keymap.set("n", "<Leader>go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
    vim.keymap.set("n", "<Leader>gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    vim.keymap.set("n", "<Leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    vim.keymap.set("n", "<Leader>gc", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)

    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

    -- vim virtual text diagnostics toggle
    vim.keymap.set("n", "<leader>tdd", function()
      vim.diagnostic.config {
        virtual_lines = not vim.diagnostic.config().virtual_lines,
        virtual_text = not vim.diagnostic.config().virtual_text,
      }
    end, { desc = "toggle diagnostic" })

    --  lsp on/off
    vim.keymap.set("n", "<leader>tdp", function()
      vim.lsp.enable("basedpyright", false)
    end, { desc = "toggle basedright off" })

    vim.keymap.set("n", "<leader>tdP", function()
      vim.lsp.enable("basedpyright", true)
    end, { desc = "toggle basedright on" })

    vim.keymap.set("n", "<leader>tdr", function()
      vim.lsp.enable("ruff", false)
    end, { desc = "toggle ruff off" })

    vim.keymap.set("n", "<leader>tdR", function()
      vim.lsp.enable("ruff", true)
    end, { desc = "toggle ruff on"  })
  end,
})

-- This is copied straight from blink
-- https://cmp.saghen.dev/installation#merging-lsp-capabilities
local capabilities = {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
}

capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

-- Setup language servers.

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
})

-- Enable each language server by filename under the lsp/ folder
vim.lsp.enable({ "gopls", "basedpyright", "luals", "ruff", "rust_analyzer", "css_lsp", "htmx"})
