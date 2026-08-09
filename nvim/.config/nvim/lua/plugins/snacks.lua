return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		require("snacks").setup({
			bigfile = { enabled = true },
			indent = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			image = { enabled = false },
			dashboard = {
				enabled = true,
				preset = {
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = ":lua Snacks.dashboard.pick('files')",
						},
						{
							icon = " ",
							key = "g",
							desc = "Find Text",
							action = ":lua Snacks.dashboard.pick('live_grep')",
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent Files",
							action = ":lua Snacks.dashboard.pick('oldfiles')",
						},
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
						},
						{
							icon = "󰒲 ",
							key = "L",
							desc = "Lazy",
							action = ":Lazy",
							enabled = package.loaded.lazy ~= nil,
						},
						{ icon = "󰣪 ", key = "M", desc = "Mason", action = ":Mason" },
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
			},

			explorer = { enabled = true },
			picker = {
				enabled = true,
				matcher = { frecency = true },
				layouts = {
					default = {
						layout = {
							box = "horizontal",
							width = 0.8,
							min_width = 120,
							height = 0.8,
							{
								box = "vertical",
								border = true,
								title = "{title} {live} {flags}",
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
							{ win = "preview", title = "{preview}", border = true, width = 0.65 },
						},
					},
				},
			},
		})

		-- Help function for setting keymaps
		local keymap = function(key, callback, desc)
			vim.keymap.set("n", key, callback, { desc = desc })
		end

		-- Open File Explorer
		keymap("<leader>e", function()
			Snacks.explorer.reveal()
		end, "Open File Explorer")

		-- Grep Open Buffers
		keymap("<leader>sb", function()
			Snacks.picker.grep_buffers()
		end, "Grep Open Buffers")

		-- Grep
		keymap("<leader>sg", function()
			Snacks.picker.grep()
		end, "Grep")

		-- Find Config File
		keymap("<leader>sn", function()
			Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
		end, "Find Config File")

		-- Find Files
		keymap("<leader>sf", function()
			Snacks.picker.files({
				finder = "files",
				format = "file",
				show_empty = true,
				hidden = true,
				supports_live = true,
				exclude = { "*.xlsx", "*.txt" },
			})
		end, "Find Files")

		-- Smart Find Files
		keymap("<leader>ss", function()
			Snacks.picker.smart()
		end, "Smart Find Files")

		-- Find Buffers
		keymap("<leader><leader>", function()
			Snacks.picker.buffers()
		end, "Find Buffers")
	end,
}
