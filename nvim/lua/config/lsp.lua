-- This is where you enable features that only work
--
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
  end,
})

-- Diagnostic / LSP toggles are global (not buffer-scoped), so set them once
-- rather than re-registering on every LspAttach.

-- vim virtual text diagnostics toggle
vim.keymap.set("n", "<leader>tdd", function()
  vim.diagnostic.config {
    virtual_lines = not vim.diagnostic.config().virtual_lines,
    virtual_text = not vim.diagnostic.config().virtual_text,
  }
end, { desc = "toggle diagnostic" })

--  lsp on/off
vim.keymap.set("n", "<leader>tdp", function()
  vim.lsp.enable("pyright", false)
end, { desc = "toggle pyright off" })

vim.keymap.set("n", "<leader>tdP", function()
  vim.lsp.enable("pyright", true)
end, { desc = "toggle pyright on" })

vim.keymap.set("n", "<leader>tdr", function()
  vim.lsp.enable("ruff", false)
end, { desc = "toggle ruff off" })

vim.keymap.set("n", "<leader>tdR", function()
  vim.lsp.enable("ruff", true)
end, { desc = "toggle ruff on" })

-- Plain capabilities (no completion plugin): line-only folding keeps the
-- LSP from sending full folding ranges that we don't render.
local capabilities = {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
}

-- Setup language servers.

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
})

-- Enable each language server by filename under the lsp/ folder
vim.lsp.enable({ "gopls", "pyright", "luals", "ruff", "rust_analyzer", "css_lsp", "htmx"})

-- disable default lsp binding cause why not
for _, k in ipairs({ 'gra', 'gri', 'grn', 'grt', 'grr' }) do
  pcall(vim.keymap.del, 'n', k)
end



-- Функция для перезапуска LSP
function RestartLSP()
    local clients = vim.lsp.get_clients()
    if #clients == 0 then
        print("No active LSP clients")
        return
    end

    -- Останавливаем всех активных клиентов
    for _, client in ipairs(clients) do
        vim.lsp.stop_client(client.id)
    end

    -- Перезагружаем текущий буфер, чтобы LSP запустился снова
    vim.cmd('edit')
    print("LSP restarted")
end

-- Создаем команду :LspRestart
vim.api.nvim_create_user_command('LspRestart', RestartLSP, {})
