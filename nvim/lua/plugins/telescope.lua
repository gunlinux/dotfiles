return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "Telescope",
    keys = {
      { "<Leader>ff", "<CMD>Telescope find_files<CR>",  mode = { "n", "v" }, desc = "Telescope find file" },
      { "<Leader>fg", "<CMD>Telescope live_grep<CR>",   mode = { "n", "v" }, desc = "Telescope live grep" },
      { "<Leader>fc", "<CMD>Telescope commands<CR>",    mode = { "n", "v" }, desc = "Telescope commands" },
      { "<Leader>fk", "<CMD>Telescope keymaps<CR>",     mode = { "n", "v" }, desc = "Telescope keymaps" },
      { "<Leader>fb", "<CMD>Telescope buffers<CR>",     mode = { "n", "v" }, desc = "telescope bugffers" },
      { "<Leader>fd", "<CMD>Telescope diagnostics<CR>", mode = { "n", "v" }, desc = "telescope diagnostics" },
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
