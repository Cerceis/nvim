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
		-- Make sure you have these npm installed globally: 
		-- 1) @vue/language-server
		-- 2) typescript-language-server
		-- 3) typescript
		-- 
		-- and tsdk config below set correctly to your global typescript/lib
		lspconfig.volar.setup({
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			init_options = {
				vue = {
					hybridMode = false,
				},
				typescript = {
					-- chiyori-T14
					tsdk = "/home/chiyori/.nvm/versions/node/v22.15.1/lib/node_modules/typescript/lib"
					-- chiyori-M4PRO
					-- tsdk = "/Users/chiyori/.nvm/versions/node/v22.14.0/lib/node_modules/typescript/lib"
				}
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

		lspconfig.lua_ls.setup({})

		lspconfig.json_ls.setup({})
	end,
}
