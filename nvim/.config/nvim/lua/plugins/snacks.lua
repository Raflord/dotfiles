return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
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
				Snacks.picker.buffers({
					on_show = function()
						vim.cmd.stopinsert()
					end,
					finder = "buffers",
					format = "buffer",
					hidden = true,
					unloaded = true,
					current = true,
					sort_lastused = true,
					win = {
						input = {
							keys = {
								["d"] = "bufdelete",
							},
						},
						list = { keys = { ["d"] = "bufdelete" } },
					},
				})
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
