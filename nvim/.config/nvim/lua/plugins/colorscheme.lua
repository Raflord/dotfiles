return {
	{
		"webhooked/kanso.nvim",
		config = function()
			require("kanso").setup({
				background = { dark = "zen", light = "pearl" },
				foreground = "saturated",
			})
			vim.cmd.colorscheme("kanso")
		end,
	},
}
