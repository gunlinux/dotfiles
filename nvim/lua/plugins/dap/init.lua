return {
	event = "VeryLazy",
	"mfussenegger/nvim-dap",
	dependencies = {
		"williamboman/mason.nvim",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
		{ "igorlfs/nvim-dap-view", opts = require("plugins.dap.dapview_config") },
	},
	config = function()
		local python_path = table
			.concat({ vim.fn.stdpath("data"), "mason", "packages", "debugpy", "venv", "bin", "python" }, "/")
			:gsub("//+", "/")
		require("mason-nvim-dap").setup({
			ensure_installed = { "python", "delve" },
			handlers = {
				function(config)
					-- Keep original functionality
					require("mason-nvim-dap").default_setup(config)
				end,

				python = function(config)
					config.adapters = {
						type = "executable",
						command = python_path,
						args = {
							"-m",
							"debugpy.adapter",
						},
					}
					require("mason-nvim-dap").default_setup(config) -- don't forget this!
				end,
			},
		})
		--require("dapui").setup()
		local dap, dapui = require("dap"), require("dap-view")
		dap.listeners.before.attach.dapui_config = function()
			--daopui.open()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			--dapui.open()
			dapui.close()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			--dapui.close()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			--dapui.close()
			--
			dapui.close()
		end
		require("nvim-dap-virtual-text").setup({})
		vim.api.nvim_create_autocmd({ "FileType" }, {
			pattern = { "dap-view", "dap-view-term", "dap-repl", "dap-terminal"}, -- dap-repl is set by `nvim-dap`
			callback = function(evt)
				vim.keymap.set("n", "q", "<C-w>q", { silent = true, buffer = evt.buf })
			end,
		})
	end,
	-- dap binds
	keys = {
		{
			"<Leader>d",
			"<CMD>DapViewToggle<CR>",
			mode = { "n", "v" },
			desc = "Toggle Breakpoint",
		},
		{
			"<Leader><F8>",
			"<CMD>DapToggleBreakpoint<CR>",
			mode = { "n", "v" },
			desc = "Toggle Breakpoint",
		},
		{
			"<F5>",
			"<CMD>DapContinue<CR>",
			mode = { "n", "v" },
			desc = "Dap Continue",
		},
		{
			"<F7>",
			"<CMD>DapStepInto<CR>",
			mode = { "n", "v" },
			desc = "Dap Continue",
		},
		{
			"<F8>",
			"<CMD>DapStepInto<CR>",
			mode = { "n", "v" },
			desc = "Dap Continue",
		},
		{
			"<F9>",
			"<CMD>DapStepOver<CR>",
			mode = { "n", "v" },
			desc = "Dap Continue",
		},
	},
}
