return {
  "kndndrj/nvim-dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    -- Install tries to automatically detect the install method.
    -- lua require("dbee").install() # if dosnt work from scratch
    -- if it fails, try calling it with one of these parameters:
    --    "curl", "wget", "bitsadmin", "go"
    require("dbee").install("go")
  end,
  config = function()
    require("dbee").setup( --[[optional config]])
  end,
  keys = {
    {
      "<leader>dbe",
      "<CMD>Dbee<CR>",
      desc = "Open Lazydocker floating window",
    },
  },
}
