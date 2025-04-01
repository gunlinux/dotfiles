return {
  --html = {},
  bashls = {},
  gopls = {},
  ruff = {
    --[[
    trace = "messages",
    init_options = {
      settings = {
        logLevel = "debug",
      },
    },
    ]]--
  },
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  },
  jsonls = {},
  pyright = {
    settings = {
      pyright = {
        -- Using Ruff's import organizer
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          typeCheckingMode = "basic"
        },
      },
    },
  },
}
