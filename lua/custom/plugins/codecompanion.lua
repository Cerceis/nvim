return{
	-- Code companion
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()

			vim.api.nvim_create_user_command("CC", "CodeCompanion <args>", { nargs = "*", range = true })

			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = "ollama"
					},
					inline = {
						adapter = "ollama",
						keymaps = {
							accept_change = {
								modes = { n = "ga" },
								description = "OK!🤍",
							},
							reject_change = {
								modes = { n = "gr" },
								opts = { nowait = true },
								description = "NO! イヤだ！",
							},
						},
					},
					cmd = {
						adapter = "ollama"
					}
				},
				adapters = {
					http = {
						ollama = function()
							return require("codecompanion.adapters").extend("ollama", {
								-- 1. Set the URL in 'env'
								env = {
									url = "http://localhost:11434",
								},
								-- 2. Set the Model in 'schema' (Fixes the other warning)
								schema = {
									model = {
										default = "deepseek-coder-v2:latest",
									},
								},
								parameters = {
									-- Only put valid LLM parameters here (like temperature)
									-- 'sync = true' is often ignored or invalid for the API parameters
									temperature = 1,
								},
							})
						end,
					},
				},
			})
		end,
	},
}
