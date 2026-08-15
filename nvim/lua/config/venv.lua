-- venv-selector.nvim, restored from the original nvim config.

require("venv-selector").setup({
  options = {
    enable_cached_venvs = true,
    cached_venv_automatic_activation = true,
    require_lsp_activation = false,
  },
})
vim.keymap.set({ "n", "v" }, "<Leader>vs", "<cmd>VenvSelect<cr>", { desc = "venvselect" })

-- pyright attaches AFTER venv-selector's FileType autocmd runs (venv.lua loads
-- before config.lsp), so the initial cached-venv activation finds no python LSP
-- client and no-ops -- pyright ends up analyzing with the system interpreter.
-- Re-apply the venv once pyright is actually up so it uses the right environment.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "pyright" then return end
    if vim.b[args.buf].venv_reapplied then return end -- guard against restart loop
    vim.b[args.buf].venv_reapplied = true
    vim.schedule(function()
      local ok, vs = pcall(require, "venv-selector")
      if ok and vs.python() then vs.restart_lsp_servers() end
    end)
  end,
})
