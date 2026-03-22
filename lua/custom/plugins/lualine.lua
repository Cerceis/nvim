return{
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()

		-- YoRHa mode display — tactical labels
		local function cute_mode()
			local mode = vim.fn.mode()
			local icons = {
				n = '-- NORMAL --',
				i = '-- INSERT --',
				v = '-- VISUAL --',
				V = '-- V-LINE --',
				[''] = '-- V-BLOCK --',
				c = '-- COMMAND --',
				R = '-- REPLACE --',
				t = '-- TERMINAL --',
			}
			return icons[mode] or ('-- ' .. mode .. ' --')
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

			return relpath ~= '' and relpath or '[no file]'
		end

		-- YoRHa tactical time
		local function dynamic_time()
			return os.date("%H:%M")
		end


		local function battery_status()
			local is_mac = vim.fn.has("macunix") == 1
			local cmd = is_mac and "pmset -g batt" or "acpi -b 2>/dev/null"

			local handle = io.popen(cmd)
			if not handle then return "PWR N/A" end
			local result = handle:read("*a")
			handle:close()
			if not result or result == "" then return "PWR N/A" end

			local percentage, charging

			if is_mac then
				percentage = tonumber(result:match("(%d?%d?%d)%%"))
				charging = result:match("charging") or result:match("AC Power")
			else
				percentage = tonumber(result:match("(%d?%d?%d)%%"))
				charging = result:match("Charging")
			end

			if not percentage then return "PWR N/A" end

			local total = 5
			local filled = math.floor(percentage / 100 * total)
			local empty = total - filled
			local bar = "[" .. string.rep("=", filled) .. string.rep("-", empty) .. "]"
			local status_icon = charging and "+" or "-"

			return string.format("PWR %s%s%d%%%%", bar, status_icon, percentage)
		end

		-- NieR:Automata lualine theme
		local nier_theme = {
			normal = {
				a = { fg = '#0a0a0c', bg = '#B4A882', gui = 'bold' },
				b = { fg = '#DAD4BB', bg = '#1a1a1e' },
				c = { fg = '#A09880', bg = 'NONE' },
			},
			insert = {
				a = { fg = '#0a0a0c', bg = '#50C878', gui = 'bold' },
				b = { fg = '#DAD4BB', bg = '#1a1a1e' },
				c = { fg = '#A09880', bg = 'NONE' },
			},
			visual = {
				a = { fg = '#0a0a0c', bg = '#B868C0', gui = 'bold' },
				b = { fg = '#DAD4BB', bg = '#1a1a1e' },
				c = { fg = '#A09880', bg = 'NONE' },
			},
			replace = {
				a = { fg = '#0a0a0c', bg = '#CC5555', gui = 'bold' },
				b = { fg = '#DAD4BB', bg = '#1a1a1e' },
				c = { fg = '#A09880', bg = 'NONE' },
			},
			command = {
				a = { fg = '#0a0a0c', bg = '#C8C2A2', gui = 'bold' },
				b = { fg = '#DAD4BB', bg = '#1a1a1e' },
				c = { fg = '#A09880', bg = 'NONE' },
			},
			inactive = {
				a = { fg = '#A09880', bg = '#111113' },
				b = { fg = '#A09880', bg = '#111113' },
				c = { fg = '#787060', bg = 'NONE' },
			},
		}

		require('lualine').setup {
			options = {
				icons_enabled = true,
				theme = nier_theme,
				component_separators = { left = '│', right = '│'},
				section_separators = { left = '', right = ''},
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
					{'branch', icon = ''},
					{'diff', symbols = { added = '+', modified = '~', removed = '-' }},
					{'diagnostics', symbols = { error = 'E:', warn = 'W:', info = 'I:', hint = 'H:' }},
				},
				lualine_c = {
					relative_path_from_root
				},
				lualine_x = {
					battery_status,
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
					battery_status,
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
