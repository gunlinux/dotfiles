return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = "Telescope",
    keys = {
      { "<Leader>ff", "<CMD>Telescope find_files<CR>", mode = { "n", "i", "v" }, desc = "Telescope find file" },
      { "<Leader>fg", "<CMD>Telescope live_grep<CR>",  mode = { "n", "i", "v" }, desc = "Telescope live grep" },
      { "<Leader>fc", "<CMD>Telescope commands<CR>",   mode = { "n", "i", "v" }, desc = "Telescope commands" },
      { "<Leader>fk", "<CMD>Telescope keymaps<CR>",    mode = { "n", "i", "v" }, desc = "Telescope keymaps" },
      { "<Leader>fb", "<CMD>Telescope buffers<CR>",    mode = { "n", "i", "v" }, desc = "telescope bugffers" },
    },
    config = true,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- even more opts
            }),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
