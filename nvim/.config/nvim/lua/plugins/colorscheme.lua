return {
	{
		"marko-cerovac/material.nvim",
		config = function()
			require("material").setup({
				high_visibility = { darker = true },
				contrast = { cursor_line = true },
				styles = { comments = { italic = true } },
				plugins = {
					"gitsigns",
					"mini",
					"nvim-cmp",
					"nvim-notify",
					"nvim-web-devicons",
					"telescope",
					"which-key",
				},

				-- Custom groups highlight colors
				custom_highlights = {
					Normal = { bg = "#212121" },
					Identifier = { fg = "#FFCB6B" },
					["@variable"] = { fg = "#EEFFFF" },
					["@variable.parameter"] = { fg = "#EEFFFF" },
					["@variable.member"] = { fg = "#EEFFFF" },
					["@property"] = { fg = "#EEFFFF" },
					["@operator"] = { fg = "#C792EA" },
					["@keyword"] = { fg = "#C792EA" },
					["@keyword.conditional"] = { fg = "#88DDFF" },
					["@keyword.return"] = { fg = "#88DDFF" },
					["@keyword.import"] = { fg = "#C792EA" },
					["@type"] = { fg = "#FFCB6B" },
					["@tag.builtin"] = { fg = "#F07178" },
					["@punctuation.bracket"] = { fg = "#DA70D6" },
					["@markup.link.label.html"] = { fg = "#EEFFFF" },
					["@markup.heading"] = { fg = "#EEFFFF" },
					["@string.special.templ"] = { fg = "#EEFFFF" },

					-- rainbow-delimters colors
					RainbowDelimiterYellow = { fg = "#FFD700" },
					RainbowDelimiterViolet = { fg = "#DA70D6" },
					RainbowDelimiterCyan = { fg = "#88DDFF" },
					RainbowDelimiterBlue = { fg = "#179FFF" },
				},
			})

			vim.g.material_style = "darker"
		end,
	},
	{
		"webhooked/kanso.nvim",
		config = function()
			require("kanso").setup({
				background = { dark = "zen", light = "pearl" },
				foreground = "saturated",
			})
		end,
	},
	{
		"vague-theme/vague.nvim",
		config = function()
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					vim.api.nvim_set_hl(0, "NormalFloat", {
						link = "Normal",
					})

					vim.api.nvim_set_hl(0, "FloatBorder", {
						link = "Normal",
					})
				end,
			})
			require("vague").setup({
				on_highlights = function(hl, colors)
					local custom_highlights = {
						["@markup.link.label.html"] = { fg = colors.fg, bold = false },
						["@markup.link.label.tsx"] = { fg = colors.fg, bold = false },
						["@markup.heading"] = { fg = colors.fg, bold = false },
						["@string.special.templ"] = { fg = colors.fg, bold = false },
					}

					for group, styles in pairs(custom_highlights) do
						hl[group] = vim.tbl_extend("force", hl[group] or {}, styles)
					end
				end,
			})
		end,
	},
}
