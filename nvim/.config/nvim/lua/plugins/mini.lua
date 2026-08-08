return {
	"nvim-mini/mini.nvim",
	version = false,
	lazy = true,
	event = "VeryLazy",
	config = function()
		-- Comment toggling (gc, gb, etc.)
		require("mini.comment").setup()
		-- Surround (add/delete/change surrounding characters)
		require("mini.surround").setup()
		-- Show git diffs and hunks
		require("mini.diff").setup({
			view = {
				style = "sign",
				signs = { add = "▎", change = "▎", delete = "▁" },
				priority = 199,
			},
		})
		-- Handle notifications
		require("mini.notify").setup({
			content = {
				-- Filter out or reorder notifications simultaneously shown
				sort = function(notif_arr)
					local filtered = {}
					for _, notif in ipairs(notif_arr) do
						-- skip "No information available" messages
						if not notif.msg:find("No information available") then
							table.insert(filtered, notif)
						end
					end

					-- Sort remaining notifications (newest first)
					table.sort(filtered, function(a, b)
						return a.ts_add > b.ts_add
					end)

					return filtered
				end,
			},
		})
		-- File manager
		local files = require("mini.files")
		files.setup({
			mappings = {
				close = "q",
				go_in = "l",
				go_in_plus = "<CR>",
				go_out = "H",
				go_out_plus = "h",
				mark_goto = "'",
				mark_set = "m",
				reset = ",",
				reveal_cwd = ".",
				show_help = "g?",
				synchronize = "s",
				trim_left = "<",
				trim_right = ">",
			},
			options = {
				-- Whether to delete permanently or move into module-specific trash
				permanent_delete = true,
				-- Whether to use for editing directories
				use_as_default_explorer = true,
			},
			windows = {
				-- Whether to show preview of file/directory under cursor
				preview = true,
			},
		})

		-- Custom keymap
		vim.keymap.set("n", "-", function()
			files.open(vim.api.nvim_buf_get_name(0), true)
		end, { desc = "Open mini.files" })
	end,
}
