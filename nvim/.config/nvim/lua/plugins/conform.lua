return {
	"stevearc/conform.nvim",
	event = { "BufWrite", "BufWritePre" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				xml = { "xmlformatter" },
				javascript = { "biome-check", "prettierd", "prettier" },
				typescript = { "biome-check", "prettierd", "prettier" },
				javascriptreact = { "biome-check", "prettierd", "prettier" },
				typescriptreact = { "biome-check", "prettierd", "prettier" },
				json = { "biome-check", "prettierd", "prettier" },
				jsonc = { "biome-check", "prettierd", "prettier" },
				css = { "biome-check", "prettierd", "prettier" },
				html = { "superhtml" },
				yaml = { "yamlfmt" },
				markdown = { "biome-check", "prettierd", "prettier" },
				python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
				bash = { "shfmt" },
				go = { "gofumpt", "goimports" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})
	end,
}
