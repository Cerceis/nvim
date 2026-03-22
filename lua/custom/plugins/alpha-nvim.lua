-- YoRHa Terminal -- Dashboard
return {
	'goolord/alpha-nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	lazy = false,
	priority = 100,
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local memo_path = vim.fn.stdpath("config") .. "/lua/memo/memo"

		-- YoRHa Tactical Boot Sequence
		local yorha_art = {
			"",
			"",
			"   +===============================================================+",
			"   |                                                               |",
			"   |     ███╗   ██╗ ██╗ ███████╗ ██████╗                           |",
			"   |     ████╗  ██║ ██║ ██╔════╝ ██╔══██╗    ┌──────────────┐      |",
			"   |     ██╔██╗ ██║ ██║ █████╗   ██████╔╝    | YoRHa Tac-OS |      |",
			"   |     ██║╚██╗██║ ██║ ██╔══╝   ██╔══██╗    | Unit: 2B     |      |",
			"   |     ██║ ╚████║ ██║ ███████╗ ██║  ██║    └──────────────┘      |",
			"   |     ╚═╝  ╚═══╝ ╚═╝ ╚══════╝ ╚═╝  ╚═╝    a]utomata          |",
			"   |                                                               |",
			"   +===============================================================+",
			"",
			"    > System boot complete                     ver: 1.25a",
			"    > Tactical log link ...................... status: OPERATIONAL",
			"    > Black box ............................ status: NOMINAL",
			"",
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
				table.insert(lines, "[ No tactical memo found ]")
			end
			return lines
		end

		local function update_memo()
			dashboard.section.memo = {
				type = "text",
				val = read_memo(memo_path),
				opts = {
					position = "center",
					hl = "Comment"
				},
			}
		end

		-- HUD Action Buttons
		dashboard.section.buttons = {
			type = "group",
			val = {
				dashboard.button("e", "  >  New File", "<cmd>ene<CR>"),
				dashboard.button("f", "  o  Find File", "<cmd>Telescope find_files<CR>"),
				dashboard.button("g", "  o  Grep Text", "<cmd>Telescope live_grep<CR>"),
				dashboard.button("r", "  o  Recent Files", "<cmd>Telescope oldfiles<CR>"),
				dashboard.button("t", "  +  File Tree", "<cmd>Neotree toggle<CR>"),
				dashboard.button("m", "  #  Tactical Memo", "<cmd>AlphaReloadMemo<CR>"),
				dashboard.button("q", "  x  Quit", "<cmd>qa<CR>"),
			},
			opts = { spacing = 1 },
		}

		-- Set button highlight
		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts.hl = "AlphaButtons"
			button.opts.hl_shortcut = "AlphaShortcut"
		end

		local function get_dashboard_config()
			dashboard.section.header.val = yorha_art
			dashboard.section.header.opts.position = "center"
			dashboard.section.header.opts.hl = "BabyBlue"

			dashboard.section.footer = {
				type = "text",
				val = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					local plugins_loaded = stats.loaded
					local plugins_total = stats.count
					return {
						"",
						"===============================================================",
						string.format(
							"  * Plugins: %d/%d loaded   * Startup: %sms   * %s",
							plugins_loaded, plugins_total, ms, os.date("%Y.%m.%d %H:%M")
						),
						"===============================================================",
					}
				end,
				opts = { position = "center", hl = "PastelPink" },
			}

			dashboard.section.section_border = {
				type = "text",
				val = "------------- Tactical Memo -------------",
				opts = {
					position = "center",
					hl = "PastelPink"
				}
			}

			dashboard.config.layout = {
				{ type = "padding", val = 1 },
				dashboard.section.header,
				{ type = "padding", val = 1 },
				dashboard.section.buttons,
				{ type = "padding", val = 1 },
				dashboard.section.section_border,
				{ type = "padding", val = 1 },
				dashboard.section.memo,
				{ type = "padding", val = 1 },
				dashboard.section.footer,
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
