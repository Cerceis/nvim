return {
	-- DO NOT INSTALL ts_ls !!!!!
	-- also make sure to install npm install -g @vue/vue-language-server
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_registry = require("mason-registry")

		-- Set up Volar
		lspconfig.volar.setup({
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			init_options = {
				vue = {
					hybridMode = false,
				},
			},
		})

		-- Set up Rust
		lspconfig.rust_analyzer.setup({
			settings = {
				["rust-analyzer"] = {
					cargo = { allFeatures = true },
					checkOnSave = true
				},
			},
		})
	end,
}
