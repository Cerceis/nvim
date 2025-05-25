return{
	{
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			-- Set the theme style before loading
			vim.g.everforest_background = "medium"
			vim.cmd.colorscheme("everforest")


			require("custom.themes.extra-theme-settings")
		end,
	}
}
