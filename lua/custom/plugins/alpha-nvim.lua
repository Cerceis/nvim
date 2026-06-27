-- ROSE -- Dashboard with spinning 3D heart
return {
	'goolord/alpha-nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	lazy = false,
	priority = 100,
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local heart = require("custom.themes.heart3d")
		local memo_path = vim.fn.stdpath("config") .. "/lua/memo/memo"

		-- Precompute spin frames once (cheap to cycle thereafter)
		local frames = heart.build(48)
		local frame_idx = 1

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
				opts = { position = "center", hl = "Comment" },
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
		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts.hl = "AlphaButtons"
			button.opts.hl_shortcut = "AlphaShortcut"
		end

		-- Subtitle under the heart
		dashboard.section.subtitle = {
			type = "text",
			val = { "♡ ｡ﾟ･  R O S E  ･ﾟ｡ ♡" },
			opts = { position = "center", hl = "BabyBlue" },
		}

		local function get_dashboard_config()
			dashboard.section.header.val = frames[frame_idx]
			dashboard.section.header.opts.position = "center"
			dashboard.section.header.opts.hl = "AlphaHeart"

			dashboard.section.footer = {
				type = "text",
				val = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return {
						"",
						"===============================================================",
						string.format(
							"  * Plugins: %d/%d loaded   * Startup: %sms   * %s",
							stats.loaded, stats.count, ms, os.date("%Y.%m.%d %H:%M")
						),
						"===============================================================",
					}
				end,
				opts = { position = "center", hl = "PastelPink" },
			}

			dashboard.section.section_border = {
				type = "text",
				val = "------------- Tactical Memo -------------",
				opts = { position = "center", hl = "PastelPink" },
			}

			dashboard.config.layout = {
				{ type = "padding", val = 1 },
				dashboard.section.header,
				dashboard.section.subtitle,
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

		-- ── Spin animation ──
		-- Cycle frames on a timer; only act while the alpha buffer is shown,
		-- and preserve the cursor so navigation isn't disturbed.
		local timer = vim.loop.new_timer()
		timer:start(150, 110, vim.schedule_wrap(function()
			if vim.bo.filetype ~= "alpha" then return end
			frame_idx = (frame_idx % #frames) + 1
			dashboard.section.header.val = frames[frame_idx]
			local win = vim.api.nvim_get_current_win()
			local ok, cur = pcall(vim.api.nvim_win_get_cursor, win)
			pcall(alpha.redraw)
			if ok then pcall(vim.api.nvim_win_set_cursor, win, cur) end
		end))

		vim.api.nvim_create_user_command("AlphaReloadMemo", function()
			update_memo()
			alpha.setup(get_dashboard_config())
			vim.cmd("Alpha")
		end, {})
	end,
}
