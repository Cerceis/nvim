return {
{
	"catppuccin/nvim",
	lazy = false,
	priority = 1000,
	config = function()

		require("catppuccin").setup({
			flavour = "mocha",
			term_colors = true,
		})

		require("custom.themes.extra-theme-settings")

		vim.cmd("colorscheme catppuccin")
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#f2cdcd", bg = "NONE" })
		end,

	},
}
