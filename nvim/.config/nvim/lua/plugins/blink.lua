return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"folke/lazydev.nvim",
	},
	config = function()
		require("blink.cmp").setup({
			appearance = {
				nerd_font_variant = "mono",

				-- vscode kind icons
				kind_icons = {
					Class = "",
					Color = "",
					Constant = "",
					Constructor = "",
					Enum = "",
					EnumMember = "",
					Event = "",
					Field = "",
					File = "",
					Folder = "",
					Function = "",
					Interface = "",
					Keyword = "",
					Method = "",
					Module = "",
					Operator = "",
					Property = "",
					Reference = "",
					Snippet = "",
					Struct = "",
					Text = "",
					TypeParameter = "",
					Unit = "",
					Value = "",
					Variable = "",
				},
			},

			keymap = {
				preset = "enter",
			},

			completion = {
				ghost_text = {
					enabled = true,
				},

				menu = {
					border = "rounded",
					winhighlight = "Normal:FLoatBorder",
					draw = {
						padding = 1,
						columns = {
							{ "label", gap = 1 },
							{ "kind_icon", "kind", gap = 1 },
						},
					},
				},

				documentation = {
					auto_show = true,
					auto_show_delay_ms = 300,
					treesitter_highlighting = true,
					window = {
						border = "rounded",
						min_width = 20,
						max_width = 75,
						max_height = 15,
						scrollbar = false,
					},
				},
			},

			sources = {
				default = {
					"lsp",
					"snippets",
					"lazydev",
					"buffer",
					"path",
				},

				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 10,
					},
				},
			},

			fuzzy = {
				implementation = "prefer_rust_with_warning",
			},
		})
	end,
}
