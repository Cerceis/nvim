return {
	{ -- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		opts = {},
		config = function()
			require("ibl").setup {
				indent = {
					highlight = "IblIndent",   -- faint solid hearts (set in rose.lua)
					char = "♥",
					tab_char = "♥",
				},
				scope = {
					highlight = "AlphaHeart",  -- current scope glows bright rose
					show_start = false,
					show_end = false,
				},
			}
		end,
	},
}
