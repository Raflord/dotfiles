return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdwinEnter" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind.nvim",
		"rafamadriz/friendly-snippets",
		"nvim-treesitter/nvim-treesitter",
		"roobert/tailwindcss-colorizer-cmp.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
		local colorizer = require("tailwindcss-colorizer-cmp").formatter

		local lsp_kinds = {
			Class = " ",
			Color = " ",
			Constant = " ",
			Constructor = " ",
			Enum = " ",
			EnumMember = " ",
			Event = " ",
			Field = " ",
			File = " ",
			Folder = " ",
			Function = " ",
			Interface = " ",
			Keyword = " ",
			Method = " ",
			Module = " ",
			Operator = " ",
			Property = " ",
			Reference = " ",
			Snippet = " ",
			Struct = " ",
			Text = " ",
			TypeParameter = " ",
			Unit = " ",
			Value = " ",
			Variable = " ",
		}

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			experimental = {
				ghost_text = true,
			},
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			window = {
				completion = {
					border = "rounded",
					winhighlight = "Normal:None,FloatBorder:None,Search:None",
				},
				documentation = cmp.config.window.bordered(),
			},
			-- config nvim cmp to work with snippet engine
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			-- autocompletion sources
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "lazydev" },
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
				{ name = "tailwindcss-colorizer-cmp" },
			}),

			mapping = cmp.mapping.preset.insert({
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<C-d>"] = cmp.mapping(function()
					cmp.close_docs()
				end, { "i", "s" }),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<Down>"] = cmp.mapping.select_next_item(),
				["<Up>"] = cmp.mapping.select_prev_item(),
				["<C-y>"] = cmp.mapping.confirm({ select = false }),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),

			-- setup lspkind for vscode pictograms in autocompletion dropdown menu
			formatting = {
				format = function(entry, vim_item)
					-- Add custom lsp_kinds icons
					vim_item.kind = string.format("%s %s", lsp_kinds[vim_item.kind] or "", vim_item.kind)

					-- add menu tags (e.g., [Buffer], [LSP])
					vim_item.menu = ({
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[Lua]",
						latex_symbols = "[LaTeX]",
					})[entry.source.name]

					-- use lspkind and tailwindcss-colorizer-cmp for additional formatting
					vim_item = lspkind.cmp_format({
						maxwidth = 25,
						ellipsis_char = "...",
					})(entry, vim_item)

					if entry.source.name == "nvim_lsp" then
						vim_item = colorizer(entry, vim_item)
					end

					return vim_item
				end,
			},
		})
	end,
}
