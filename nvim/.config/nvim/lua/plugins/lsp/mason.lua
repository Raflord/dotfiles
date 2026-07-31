return {
	"mason-org/mason.nvim",
	lazy = false,
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- lsp
		mason_lspconfig.setup({
			automatic_enable = false,
			-- servers for mason to install
			ensure_installed = {
				"lua_ls",
				"tsgo",
				"html",
				"tailwindcss",
				"gopls",
				"emmet_ls",
				"emmet_language_server",
				"marksman",
				"superhtml",
				"ruff",
				"ty",
				"templ",
			},
		})
		-- formatters
		mason_tool_installer.setup({
			ensure_installed = {
				"prettierd",
				"prettier",
				"stylua",
				"xmlformatter",
				"biome",
				"ruff",
			},
		})
	end,
}
