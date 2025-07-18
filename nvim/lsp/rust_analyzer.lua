---@type vim.lsp.Config
return {
  cmd = { 'rust-analyzer'}, -- ,  '--stdio' },
  filetypes = { 'rust' },
  root_markers = {
    'Cargo.toml',
    '.git',
  },
}
