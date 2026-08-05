require("core")
require("lazy_setup")

-- set colorscheme here
vim.cmd.colorscheme("vague")

vim.diagnostic.config({
	float = {
		border = "rounded",
		source = "if_many",
		-- header = "",
		-- prefix = "",
	},
})
