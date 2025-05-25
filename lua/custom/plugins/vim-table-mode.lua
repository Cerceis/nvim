return{
	{
	  "dhruvasagar/vim-table-mode",
	  ft = { "markdown", "text", "org" }, -- Enable only for relevant filetypes
	  init = function()
		-- Optional settings (customize to taste)
		vim.g.table_mode_corner = '|' -- Use pipe character for tables
	  end,
	  keys = {
		{ "<leader>tm", "<cmd>TableModeToggle<CR>", desc = "Toggle Table Mode" },
	  }
	}
}
