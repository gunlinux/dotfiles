---@type vim.lsp.Config
return {
  cmd = { 'uvx', 'ruff', 'server' }, -- ,  '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.git',
  },
}
