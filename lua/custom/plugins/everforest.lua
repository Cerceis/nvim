return{
	{
		"sainnhe/everforest",
		lazy = false,
		priority = 99,
		config = function()
			-- Set the theme style before loading
			vim.g.everforest_background = "medium"
			vim.cmd.colorscheme("everforest")

			-- Set the line number with custom color
			vim.api.nvim_set_hl(0, "LineNr", { fg = "#a599e9", bg = "NONE" })

			-- Make background transparent to respect kitty's opacity
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
			vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
			vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
			vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })

			-- Some custom schema
			vim.api.nvim_set_hl(0, "BabyBlue", { fg = "#add8e6" })
			vim.api.nvim_set_hl(0, "PastelPink", { fg = "#8b6f7f" })	
			vim.api.nvim_set_hl(0, "Lilac", { fg = "#d9b2d9" })
			
		end,
	}
}
