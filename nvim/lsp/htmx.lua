---@type vim.lsp.Config
return {
  cmd = { '/usr/bin/npx', 'htmx-lsp' },
  filetypes = { 'htmx', 'html' },
  root_markers = { '.git' },
}
