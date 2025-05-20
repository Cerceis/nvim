return{
	-- Code companion
	{
		vim.keymap.set("v", "<leader>ai",
			function()
				require("codecompanion").chat.inline()
			end,
			{
				desc = "Inline Chat with CodeCompanion",
				noremap = true,
				silent = true,
	 		}
		)
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = "ollama"
					},
					inline = {
						adapter = "ollama"
					},
					cmd = {
						adapter = "ollama"
					}
				},
				adapters = {
					ollama = function()
						return require("codecompanion.adapters").extend("ollama",{
							env = {
								url = "http://localhost:11434",
								model = "deepseek-coder-v2:latest",
							},
							parameters = {
								sync = true
							}
						})

					end,
				},
			})
		end,
	},
}
