return {
	-- Hotkeys
	{
		vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle NeoTree' }),
		vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true }),
		vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true }),
		vim.keymap.set(
			"n", "<leader>l", function()
			vim.cmd("Telescope lsp_document_symbols")
			end,
			{ desc = "List fuctions and symbols in file" }
		)
	},
}
