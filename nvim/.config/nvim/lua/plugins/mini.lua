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
	end,
}
