return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		require("snacks").setup({
			bigfile = { enabled = true },
			indent = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			image = { enabled = false },
			dashboard = { enabled = true },
			explorer = { enabled = true },
			picker = {
				enabled = true,
				layout = { preset = "telescope" },
				matcher = { frecency = true },
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

		-- Show LSP References
		keymap("gR", function()
			Snacks.picker.lsp_references({
				include_current = true,
			})
		end, "Show LSP References")

		-- Show Buffer Diagnostics
		keymap("<leader>D", function()
			Snacks.picker.diagnostics_buffer()
		end, "Show Buffer Diagnostics")

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
			Snacks.picker.smart({})
		end, "Smart Find Files")

		-- Find Buffers
		keymap("<leader><leader>", function()
			Snacks.picker.buffers()
		end, "Find Buffers")
	end,
}
