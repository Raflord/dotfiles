return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		-- Show LSP References
		{
			"gR",
			function()
				Snacks.picker.lsp_references({
					include_current = true,
				})
			end,
			nowait = true,
			desc = "Show LSP References",
		},
		-- Show Buffer Diagnostics
		{
			"<leader>D",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Show Buffer Diagnostics",
		},
		-- Grep Open Buffers
		{
			"<leader>sb",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},
		-- Grep
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		-- Find Config File
		{
			"<leader>sn",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
		},
		-- Find Files
		{
			"<leader>sf",
			function()
				Snacks.picker.files({
					finder = "files",
					format = "file",
					show_empty = true,
					hidden = true,
					supports_live = true,
					exclude = { "*.xlsx", "*.txt" },
				})
			end,
			desc = "Find Files",
		},
		-- Smart Find Files
		{
			"<leader>ss",
			function()
				Snacks.picker.smart({})
			end,
			desc = "Smart Find Files",
		},
		-- Find Buffers
		{
			"<leader><leader>",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Find Buffers",
		},
	},
	opts = {
		bigfile = { enabled = true },
		indent = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		image = { enabled = false },
		picker = {
			enabled = true,
			layout = { preset = "telescope" },
			matcher = { frecency = true },
		},
	},
}
