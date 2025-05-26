-- Splash screen
return {
	'goolord/alpha-nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	lazy = false,
	priority = 100,
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local memo_path = vim.fn.stdpath("config") .. "/lua/memo/memo"
		local cute_art = {
			"  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢎⠱⠊⡱⠀⠀⠀⠀⠀⠀  ",
			"  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⠤⠒⠒⠒⠒⠤⢄⣑⠁⠀⠀⠀⠀⠀⠀⠀⠀  ",
			"  ⠀⠀⠀⠀⠀⠀⠀⢀⡤⠒⠝⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠲⢄⡀⠀⠀⠀⠀⠀  ",
			"  ⠀⠀⠀⠀⠀⢀⡴⠋⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⠀⢰⣢⠐⡄⠀⠉⠑⠒⠒⠒⣄  ",
			"  ⠀⠀⠀⣀⠴⠋⠀⠀⠀⡎⠀⠘⠿⠀⠀⢠⣀⢄⡢⠉⣔⣲⢸⠀⠀⠀⠀⠀⠀⢘  ",
			"  ⡠⠒⠉⠀⠀⠀⠀⠀⡰⢅⠫⠭⠝⠀⠀⠀⠀⠀⠀⢀⣀⣤⡋⠙⠢⢄⣀⣀⡠⠊  ",
			"  ⢇⠀⠀⠀⠀⠀⢀⠜⠁⠀⠉⡕⠒⠒⠒⠒⠒⠛⠉⠹⡄⣀⠘⡄⠀⠀⠀⠀⠀⠀  ",
			"  ⠀⠑⠂⠤⠔⠒⠁⠀⠀⡎⠱⡃⠀⠀⡄⠀⠄⠀⠀⠠⠟⠉⡷⠁⠀⠀⠀⠀⠀⠀  ",
			"  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⠤⠤⠴⣄⡸⠤⣄⠴⠤⠴⠄⠼⠀⠀⠀⠀⠀⠀⠀⠀  ",
			"                                  ",
			"<頑張るあなたに、ハグ！(っ´▽｀)っ>",
			"                                  ",
			"<Everything is going to be 大丈夫>"
		}

		local function read_memo(path)
			local lines = {}
			local f = io.open(path, "r")
			if f then
				for line in f:lines() do
					table.insert(lines, line)
				end
			else
				table.insert(lines, "(No memo found)")
			end
			return lines
		end

		local memo_lines = read_memo(memo_path)

		-- Set it as the first section
		dashboard.section.header.val = cute_art
		dashboard.section.header.opts.position = "center"
		dashboard.section.header.opts.hl = "BabyBlue"

		-- Add memo section
		dashboard.section.memo = {
			type = "text",
			val = memo_lines,
			opts = {
				position = "center",
				hl = "Comment"
			},
		}

--		dashboard.section.buttons.val = {
--			dashboard.button("q", "BYE BYE!", ":qa<CR>")
--		}

		dashboard.section.menu = {
			type = "text",
			val = "| [<leader>e] Tree | [<leader>sf] 検索 |",
			opts = {
				position = "center",
			}
		}

		dashboard.section.section_border = {
			type = "text",
			val = "─·✦·─·✧·─·✦·─·✧·─·✦·─·✧·─·✦─·(｡・ω・｡)·─✧·─·✦·─·✧·─·✦·─·✧·─·✦·─·✧·─·✦·─",
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

		-- Setup
		alpha.setup(dashboard.config)
	end,
}
