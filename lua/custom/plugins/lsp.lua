return {
	-- DO NOT INSTALL ts_ls manually via Mason if listed here, Mason will handle it via dependencies
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"b0o/schemastore.nvim", -- Needed for YAML schemas
	},
	config = function()
		-- NOTE: We do NOT use require('lspconfig') anymore.

		-- 1. Volar
		vim.lsp.config('vue_ls', {
			filetypes = { "vue" },
			init_options = {
				typescript = {
					tsdk = "/Users/chiyori/.nvm/versions/node/v22.14.0/lib/node_modules/typescript/lib",
				},
				vue = {
					hybridMode = false,
				},
			},
		})
		vim.lsp.enable('vue_ls')

		-- 2. TS_LS
		vim.lsp.config('ts_ls', {
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
			},
		})
		vim.lsp.enable('ts_ls')

		-- 3. Rust Analyzer
		vim.lsp.config('rust_analyzer', {
			settings = {
				["rust-analyzer"] = {
					cargo = { allFeatures = true },
					checkOnSave = true
				},
			},
		})
		vim.lsp.enable('rust_analyzer')

		-- 4. Lua LS
		vim.lsp.config('lua_ls', {})
		vim.lsp.enable('lua_ls')

		-- 5. JSON LS
		vim.lsp.config('jsonls', {})
		vim.lsp.enable('jsonls')

		-- 6. Yaml LS
		vim.lsp.config('yamlls', {
			settings = {
				yaml = {
					schemas = require("schemastore").yaml.schemas(),
					validate = true,
				}
			}
		})
		vim.lsp.enable('yamlls')
	end,
}
