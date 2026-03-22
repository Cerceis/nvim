-- NieR:Automata Dark — Plugin Spec
-- Use this as your theme plugin file to activate the NieR colorscheme
return {
	{
		dir = vim.fn.stdpath("config"),
		name = "nier-colorscheme",
		lazy = false,
		priority = 1000,
		config = function()
			require("custom.themes.nier").setup()
			require("custom.themes.extra-theme-settings")
		end,
	},
}
