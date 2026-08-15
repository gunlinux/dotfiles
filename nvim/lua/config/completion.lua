-- Built-in completion (replaces blink.cmp).
--
-- Uses Neovim's native LSP completion with autotrigger, so typing trigger
-- characters (`.`, `(`, etc.) opens the popup menu without any plugin.
-- Snippets from friendly-snippets are not ported (no built-in snippet engine);
-- keyword (<C-n>/<C-p>) and path (<C-x><C-f>) completion are always available.

vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.pumheight = 10
vim.opt.shortmess:append("c") -- hide "match 1 of N" messages

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Enable LSP completion",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or not client:supports_method("textDocument/completion") then
      return
    end
    -- autotrigger=true: completion pops up on the server's triggerCharacters.
    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    -- manual trigger via <C-x><C-o>
    vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
  end,
})
