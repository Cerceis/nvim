-- YoRHa Terminal — Dashboard
return {
	'goolord/alpha-nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	lazy = false,
	priority = 100,
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local memo_path = vim.fn.stdpath("config") .. "/lua/memo/memo"
		local yorha_art = {
			"                                                              ",
			"                                                              ",
			"     ███╗   ██╗ ██╗ ███████╗ ██████╗        ╔══════════╗      ",
			"     ████╗  ██║ ██║ ██╔════╝ ██╔══██╗       ║ ヨルハ   ║      ",
			"     ██╔██╗ ██║ ██║ █████╗   ██████╔╝       ║ 戦術OS  ║      ",
			"     ██║╚██╗██║ ██║ ██╔══╝   ██╔══██╗       ╚══════════╝      ",
			"     ██║ ╚████║ ██║ ███████╗ ██║  ██║                         ",
			"     ╚═╝  ╚═══╝ ╚═╝ ╚══════╝ ╚═╝  ╚═╝    a]utomata          ",
			"                                                              ",
			"     ───────────────────────────────────────────────           ",
			"      型式: 2B     版: 1.25a     状態: 作戦可能               ",
			"     ───────────────────────────────────────────────           ",
			"                                                              ",
		}

		local function read_memo(path)
			local lines = {}
			local f = io.open(path, "r")
			if f then
				for line in f:lines() do
					table.insert(lines, line)
				end
				f:close()
			else
				table.insert(lines, "[ 戦術メモ未検出 ]")
			end
			return lines
		end


		local function update_memo()
			-- Add memo section
			dashboard.section.memo = {
				type = "text",
				val = read_memo(memo_path),
				opts = {
					position = "center",
					hl = "Comment"
				},
			}
		end

		local function get_dashboard_config()
			-- Set it as the first section
			dashboard.section.header.val = yorha_art
			dashboard.section.header.opts.position = "center"
			dashboard.section.header.opts.hl = "BabyBlue"


				dashboard.section.menu = {
					type = "text",
					val = "│ [<leader>e] 樹形図 │ [<leader>sf] 検索 │",
					opts = {
						position = "center",
					}
				}

				dashboard.section.section_border = {
					type = "text",
					val = "════════════════════════════════════════════════════════════════════════════════",
					opts = {
						position = "center",
						hl = "PastelPink"
					}
				}

				dashboard.config.layout = {
					{ type = "padding", val = 1 },
					dashboard.section.header,
					{ type = "padding", val = 1 },
					dashboard.section.menu,
					{ type = "padding", val = 1 },
					dashboard.section.section_border,
					{ type = "padding", val = 1 },
					dashboard.section.memo,
				}

				return dashboard.config
			end

			-- Setup
			update_memo()
			alpha.setup(get_dashboard_config())

			vim.api.nvim_create_user_command("AlphaReloadMemo", function()
				update_memo()
				alpha.setup(get_dashboard_config())
				vim.cmd("Alpha")
			end, {})

		end,
	}
