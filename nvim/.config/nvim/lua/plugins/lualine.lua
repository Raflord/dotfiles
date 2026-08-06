return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local mode = {
			"mode",
			fmt = function(str)
				return " " .. str
			end,
		}

		local diff = {
			"diff",
			colored = true,
			symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
		}

		local filename = {
			"filename",
			file_status = true,
			path = 0,
		}

		local branch = { "branch", icon = { "", color = { fg = "#A6D4DE" } }, "|" }

		local macro = {
			function()
				local register = vim.fn.reg_recording()
				if register == "" then
					return ""
				end
				return "Recording @" .. register
			end,
			color = { fg = "#ff9e64", gui = "bold" },
		}

		lualine.setup({
			icons_enabled = true,
			options = {
				theme = "auto",
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { branch },
				lualine_c = { diff, filename },
				lualine_x = {
					macro,
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "filetype" },
				},
			},
		})
	end,
}
