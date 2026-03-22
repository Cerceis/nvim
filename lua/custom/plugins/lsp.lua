return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"saghen/blink.cmp",
		"b0o/schemastore.nvim",
	},
	config = function()
		-- ══════════════════════════════════════════════
		--  Keybindings & Autocmds
		-- ══════════════════════════════════════════════

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
				map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
				map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
				map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

				local client = vim.lsp.get_client_by_id(event.data.client_id)

				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- ══════════════════════════════════════════════
		--  Diagnostics
		-- ══════════════════════════════════════════════

		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = vim.g.have_nerd_font and {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			} or {},
			virtual_text = {
				source = "if_many",
				spacing = 2,
				format = function(diagnostic)
					return diagnostic.message
				end,
			},
		})

		-- ══════════════════════════════════════════════
		--  Capabilities (blink.cmp)
		-- ══════════════════════════════════════════════

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- ══════════════════════════════════════════════
		--  Mason
		-- ══════════════════════════════════════════════

		require("mason-tool-installer").setup({
			ensure_installed = {
				"stylua",
				"json-lsp",
				"yaml-language-server",
				"html-lsp",
				"lua-language-server",
				"rust-analyzer",
				"typescript-language-server",
				"vue-language-server",
				"clangd",
			},
		})
		require("mason-lspconfig").setup({
			ensure_installed = {},
			automatic_installation = false,
		})

		-- ══════════════════════════════════════════════
		--  Helpers
		-- ══════════════════════════════════════════════

		--- Find typescript lib: project-local first, then global nvm
		local function get_tsdk()
			local local_ts = vim.fn.getcwd() .. "/node_modules/typescript/lib"
			if vim.fn.isdirectory(local_ts) == 1 then
				return local_ts
			end
			local node_path = vim.fn.exepath("node")
			if node_path ~= "" then
				local global_ts = vim.fn.fnamemodify(node_path, ":h:h") .. "/lib/node_modules/typescript/lib"
				if vim.fn.isdirectory(global_ts) == 1 then
					return global_ts
				end
			end
			return ""
		end

		--- Find @vue/language-server path (used by ts_ls plugin)
		local function get_vue_language_server_path()
			local candidates = {
				vim.fn.getcwd() .. "/node_modules/@vue/language-server",
				vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
			}
			local handle = io.popen("npm root -g 2>/dev/null")
			if handle then
				local global_root = handle:read("*l")
				handle:close()
				if global_root then
					table.insert(candidates, global_root .. "/@vue/language-server")
				end
			end
			for _, path in ipairs(candidates) do
				if vim.fn.isdirectory(path) == 1 then
					return path
				end
			end
			return ""
		end

		-- ══════════════════════════════════════════════
		--  Servers
		-- ══════════════════════════════════════════════

		local vue_language_server_path = get_vue_language_server_path()

		-- 1. Vue LS (Volar) — hybrid mode (default)
		--    Handles <template> and <style> in .vue files
		--    TS intellisense in <script> comes from ts_ls via the plugin
		vim.lsp.config("vue_ls", {
			capabilities = capabilities,
			init_options = {
				typescript = { tsdk = get_tsdk() },
			},
		})
		vim.lsp.enable("vue_ls")

		-- Fix: vue_ls in hybrid mode hangs on TS requests in <script> regions
		-- (never responds), blocking Neovim which waits for all clients.
		-- Disable only the capabilities that ts_ls handles (TS/JS).
		-- Keep diagnostics, formatting, and document-wide features for
		-- <template> HTML and <style> CSS support.
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("vue-ls-hybrid-fix", { clear = true }),
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client and client.name == "vue_ls" then
					-- Disable capabilities that conflict with ts_ls in <script>
					client.server_capabilities.hoverProvider = false
					client.server_capabilities.definitionProvider = false
					client.server_capabilities.referencesProvider = false
					client.server_capabilities.renameProvider = false
					client.server_capabilities.signatureHelpProvider = false
					client.server_capabilities.implementationProvider = false
					client.server_capabilities.typeDefinitionProvider = false
					-- Keep completionProvider, codeActionProvider, diagnostics,
					-- formatting, documentHighlight, etc. for template/style
				end
			end,
		})

		-- 2. TypeScript LS — with @vue/typescript-plugin for .vue support
		--    This is the official recommended setup from vuejs/language-tools
		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = vue_language_server_path,
						languages = { "vue" },
						configNamespace = "typescript",
					},
				},
			},
		})
		vim.lsp.enable("ts_ls")

		-- 3. Rust Analyzer
		vim.lsp.config("rust_analyzer", {
			capabilities = capabilities,
			settings = {
				["rust-analyzer"] = {
					cargo = { allFeatures = true },
					checkOnSave = true,
				},
			},
		})
		vim.lsp.enable("rust_analyzer")

		-- 4. Lua LS
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					completion = { callSnippet = "Replace" },
				},
			},
		})
		vim.lsp.enable("lua_ls")

		-- 5. JSON LS
		vim.lsp.config("jsonls", { capabilities = capabilities })
		vim.lsp.enable("jsonls")

		-- 6. YAML LS
		vim.lsp.config("yamlls", {
			capabilities = capabilities,
			settings = {
				yaml = {
					schemas = require("schemastore").yaml.schemas(),
					validate = true,
				},
			},
		})
		vim.lsp.enable("yamlls")

		-- 7. Clangd (Arduino / ESP32 / C/C++)
		vim.lsp.config("clangd", {
			capabilities = capabilities,
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
			},
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "arduino" },
			root_markers = { "platformio.ini", ".clangd", "compile_commands.json", "compile_flags.txt", ".git" },
		})
		vim.lsp.enable("clangd")

		-- 8. Emmet LS (HTML/CSS completions in vue/html/css)
		vim.lsp.config("emmet_ls", {
			capabilities = capabilities,
			filetypes = { "html", "css", "scss", "vue", "typescriptreact", "javascriptreact" },
		})
		vim.lsp.enable("emmet_ls")
	end,
}
