return {
	{ -- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		opts = {},
		config = function()
			require("ibl").setup {
				indent = {
					highlight = "PastelPink",
					char = "♡",
					tab_char = "♡",
				},
				scope = {
					highlight = "Lilac"
				}
			}
		end,
	},
}
