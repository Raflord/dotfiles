require("vim._core.ui2").enable({
	enable = true,
	msg = {
		-- Display regular messages in the command-line area.
		targets = "cmd",
		-- Maximum expanded message height.
		cmd = {
			height = 0.5,
		},
		-- Temporary message window configuration.
		msg = {
			height = 0.5,
			timeout = 5000,
		},
		-- Native pager configuration.
		pager = {
			height = 0.5,
		},
	},
})

vim.opt.winborder = "rounded"
vim.opt.cmdheight = 0 -- Keep command-line hidden when empty
vim.opt.shortmess = "altToOCFW" -- Message filtering logic natively

-- Native diagnostic floating window.
vim.diagnostic.config({
	float = {
		source = "if_many",
		header = "",
		prefix = "",
		suffix = "",
	},
})

-- Keep Markdown formatting concealed in floating documentation
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function(args)
		vim.opt_local.conceallevel = 2
		vim.opt_local.concealcursor = "nc"

		vim.bo[args.buf].syntax = "markdown"
	end,
})
