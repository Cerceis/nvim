return {
	{
		"Cerceis/mark-memo.nvim",
		config = function()
			require("mark-memo").setup({
				width = 20,
				height = 15,
				border = "rounded",
				position = "topright",
				separator = "|"
			})
		end
	}
}

