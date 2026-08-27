return {
	{
		"webhooked/kanso.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanso").setup({
				compile = true,
				background = { dark = "zen", light = "pearl" },
				foreground = "saturated",
			})
			vim.cmd.colorscheme("kanso")
		end,
	},
}
