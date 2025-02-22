return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup()
	end,
	keys = {
		{ "<Leader>b", "<CMD>BufferLinePick<CR>", mode = { "n" }, desc = "bufferline pick" },
	},
}
