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

			-- Usage: :CCF <filename> <your prompt>
			-- Example: :CCF README.md write a function to parse this file
			vim.api.nvim_create_user_command("CCF", function(opts)
				local args = vim.split(opts.args, " ")
				local file_pattern = args[1]

				-- Remove filename to get the prompt
				table.remove(args, 1)
				local user_prompt = table.concat(args, " ")

				-- 1. Find the file
				local found_file = vim.fn.findfile(file_pattern, "**")
				if found_file == "" then
					found_file = vim.fn.findfile("*" .. file_pattern .. "*", "**")
				end

				if found_file == "" then
					vim.notify("❌ CCF: Could not find file matching '" .. file_pattern .. "'", vim.log.levels.ERROR)
					return
				end

				-- 2. Read file
				local file_lines = vim.fn.readfile(found_file)
				local file_content = table.concat(file_lines, "\n")
				local file_ext = vim.fn.fnamemodify(found_file, ":e")

				-- 3. Construct Prompt
				local full_prompt = string.format(
					"Context from file '%s':\n\n```%s\n%s\n```\n\n%s",
					found_file,
					file_ext,
					file_content,
					user_prompt
				)

				-- 4. Execute CodeCompanion Inline (Safely)
				-- We use nvim_cmd to pass the huge string safely.
				-- IMPORTANT: We pass "ollama" as the first arg so the plugin knows exactly which adapter to use
				-- and doesn't try to guess it from the file content.
				local ok, err = pcall(function()
					vim.api.nvim_cmd({
						cmd = "CodeCompanion",
						args = { "ollama", full_prompt }
					}, {})
				end)

				if not ok then
					vim.notify("CCF Error: " .. tostring(err), vim.log.levels.ERROR)
				end

			end, { nargs = "+" })

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
										default = "qwen2.5-coder:14b",
									},
								},

								parameters = {
									-- Only put valid LLM parameters here (like temperature)
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



