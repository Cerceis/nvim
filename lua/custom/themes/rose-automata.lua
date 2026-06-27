-- ROSE — Plugin Spec
-- Desaturated pastel-pink colorscheme. Self-contained: it also applies
-- the editor background + dashboard accents, so no extra settings file needed.
return {
	{
		dir = vim.fn.stdpath("config"),
		name = "rose-colorscheme",
		lazy = false,
		priority = 1000,
		config = function()
			require("custom.themes.rose").setup()
		end,
	},
}
