return{
	{
	  "sainnhe/everforest",
	  config = function()
		-- Set the theme style before loading
		vim.g.everforest_background = "medium"
		vim.cmd.colorscheme("everforest")
		-- Set the line number with custom color
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#a599e9", bg = "NONE" })
	  end,
	}
}
