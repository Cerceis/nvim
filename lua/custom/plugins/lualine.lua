return{
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()

		-- A custom function that returns emoji based on modes
		local function cute_mode()
			local mode = vim.fn.mode()
			local icons = {
				n = '🐰 n:一般',
				i = '🍓 i:挿入',
				v = '🎀 v:選択',
				V = '🎀 V-LINE',
				[''] = '🎀 V-BLOCK',
				c = '🐻 c:くまですが、なにか？'
			}
			return icons[mode] or '💖 ' .. mode
		end
	
		-- A custom function that returns file path relative to project root
		local function relative_path_from_root()
			local cwd = vim.fn.getcwd()
			local file = vim.fn.expand('%:p')
			-- fallback relative
			local relpath = vim.fn.fnamemodify(file, ':~:.')
			
			if file:sub(1, #cwd) == cwd then
				relpath = file:sub(#cwd + 2)
			end
			
			return relpath ~= '' and relpath or '!404!'
		end

		-- A custom function that shows a dynamic time
		local function dynamic_time()
			local hour = tonumber(os.date("%H"))
			local time_str = os.date("%H:%M")
			
			local emoji
			if hour < 6 then
				emoji = "🧸"
			elseif hour < 12 then
				emoji = "🥐"
			elseif hour < 18 then
				emoji = "🧋"
			else
				emoji = "🧸"
			end

			return emoji .. " " .. time_str
		end

		require('lualine').setup {
			options = {
				icons_enabled = true,
				theme = 'auto',
				component_separators = { left = '♥', right = '♥'},
				section_separators = { left = '', right = ''},
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				}
			},
			sections = {
				lualine_a = { cute_mode },
				lualine_b = {
					{'branch', icon = '🌿'},
					{'diff', symbols = { added = '+', modified = '✱', removed = '-' }},
					{'diagnostics', symbols = { error = '💔 ', warn = '⚠️ ', info = '💡', hint = '✨' }},
				},
				lualine_c = {
					relative_path_from_root
				},
				lualine_x = {
					dynamic_time,
					'encoding',
					'fileformat',
					'filetype'
				},
				lualine_y = {'progress'},
				lualine_z = {
					'location',
					'searchcount',
					'selectioncount',
					'lsp_status'
				}
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					relative_path_from_root
				},
				lualine_x = {
					dynamic_time
				},
				lualine_y = {},
				lualine_z = {
					'lsp_status'
				}
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {}
		}
	end,
}
