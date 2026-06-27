return{
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()

		-- Mode display — clean labels
		local function cute_mode()
			local mode = vim.fn.mode()
			local icons = {
				n = 'NORMAL',
				i = 'INSERT',
				v = 'VISUAL',
				V = 'V·LINE',
				[''] = 'V·BLOCK',
				c = 'COMMAND',
				R = 'REPLACE',
				t = 'TERMINAL',
			}
			return '  ' .. (icons[mode] or mode:upper()) .. '  '
		end

		-- ♥ animated beating-heart sigil (pulses via the statusline refresh)
		local heart_seq = { '♥', '♥', '❤', '♥', '♡', '♥', '♥', '♥' }
		local function heart_beat()
			local i = (math.floor(vim.loop.now() / 150) % #heart_seq) + 1
			return heart_seq[i]
		end

		-- mode-aware kaomoji mascot
		local function mascot()
			local m = vim.fn.mode()
			local faces = {
				n = '(･ω･)',
				i = '(๑˃ᴗ˂)ﻭ',
				v = '(◕▿◕)',
				V = '(◕▿◕)',
				[''] = '(◣_◢)',
				c = '(・◇・)?',
				R = '(>﹏<)',
				t = '(￣▽￣)',
			}
			return faces[m] or '(・_・)'
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

		-- tactical time
		local function dynamic_time()
			return ' ' .. os.date("%H:%M")
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

		-- ROSE lualine theme (desaturated pastel pink)
		local rose_theme = {
			normal = {
				a = { fg = '#0a0a0c', bg = '#CBA1B2', gui = 'bold' },
				b = { fg = '#E2D6DB', bg = '#191418' },
				c = { fg = '#A08892', bg = 'NONE' },
			},
			insert = {
				a = { fg = '#0a0a0c', bg = '#7FB394', gui = 'bold' },
				b = { fg = '#E2D6DB', bg = '#191418' },
				c = { fg = '#A08892', bg = 'NONE' },
			},
			visual = {
				a = { fg = '#0a0a0c', bg = '#C18FB0', gui = 'bold' },
				b = { fg = '#E2D6DB', bg = '#191418' },
				c = { fg = '#A08892', bg = 'NONE' },
			},
			replace = {
				a = { fg = '#0a0a0c', bg = '#C76B7A', gui = 'bold' },
				b = { fg = '#E2D6DB', bg = '#191418' },
				c = { fg = '#A08892', bg = 'NONE' },
			},
			command = {
				a = { fg = '#0a0a0c', bg = '#D8CCD1', gui = 'bold' },
				b = { fg = '#E2D6DB', bg = '#191418' },
				c = { fg = '#A08892', bg = 'NONE' },
			},
			inactive = {
				a = { fg = '#A08892', bg = '#141015' },
				b = { fg = '#A08892', bg = '#141015' },
				c = { fg = '#6E5A63', bg = 'NONE' },
			},
		}

		require('lualine').setup {
			options = {
				icons_enabled = true,
				theme = rose_theme,
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
					statusline = 150,
					tabline = 150,
					winbar = 150,
				}
			},
			sections = {
				lualine_a = { heart_beat, cute_mode },
				lualine_b = {
					{'branch', icon = ''},
					{'diff', symbols = { added = '+', modified = '~', removed = '-' }},
					{'diagnostics', symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }},
				},
				lualine_c = {
					{ relative_path_from_root, icon = '' }
				},
				lualine_x = {
					mascot,
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
