return {
	"NvChad/nvim-colorizer.lua",
	lazy = true,
	ft = "javascript, typescript, javascriptreact, typescriptreact",
	config = function()
		require("colorizer").setup({
			user_default_options = {
				tailwind = true,
			},
			filetypes = {
				"html",
				"css",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
			},
		})
	end,
}
