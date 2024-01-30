return {
  { 
	  'nvim-telescope/telescope.nvim', 
	  tag = '0.1.2' ,
    dependencies = "nvim-lua/plenary.nvim",
    cmd = "Telescope",
    keys = {
            { "<Leader>ff", "<CMD>Telescope find_files<CR>", mode = { "n", "i", "v" } },
            { "<Leader>fg", "<CMD>Telescope live_grep<CR>", mode = { "n", "i", "v" } },
            { "<Leader>fc", "<CMD>Telescope commands<CR>", mode = { "n", "i", "v" } },
            { "<Leader>fk", "<CMD>Telescope keymaps<CR>", mode = { "n", "i", "v" } },
            { "<Leader>fb", "<CMD>Telescope buffers<CR>", mode = { "n", "i", "v" } },
        },
        config = true 
  },
}

