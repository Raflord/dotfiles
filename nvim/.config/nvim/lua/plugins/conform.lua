return {
	"stevearc/conform.nvim",
	event = { "BufWrite", "BufWritePre" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				bash = { "shfmt" },
				css = { "biome-check" },
				go = { "gofumpt", "goimports" },
				html = { "superhtml" },
				javascript = { "biome-check" },
				javascriptreact = { "biome-check" },
				json = { "biome-check" },
				jsonc = { "biome-check" },
				lua = { "stylua" },
				python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
				toml = { "taplo" },
				typescript = { "biome-check" },
				typescriptreact = { "biome-check" },
				xml = { "xmlformatter" },
				yaml = { "yamlfmt" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})
	end,
}
