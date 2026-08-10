return {
	{
		"webhooked/kanso.nvim",
		config = function()
			local color_palette = require("kanso.colors").setup({ theme = "zen" }).palette
			require("kanso").setup({
				background = { dark = "zen", light = "pearl" },
				foreground = "saturated",
				overrides = function()
					return {
						["@lsp.type.namespace.go"] = { fg = color_palette.green3Saturated },
					}
				end,
			})
			vim.cmd.colorscheme("kanso")
		end,
	},
}
