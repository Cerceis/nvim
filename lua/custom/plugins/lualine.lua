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
			return icons[mode] or ('💖 ' .. mode)
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
	

		local function battery_status()
			-- Detect OS
			local is_mac = vim.fn.has("macunix") == 1

			-- Pick the command based on OS
			local cmd = is_mac and "pmset -g batt" or "acpi -b 2>/dev/null"

			local handle = io.popen(cmd)
			if not handle then return "[🤍] N/A" end
			local result = handle:read("*a")
			handle:close()
			if not result or result == "" then return "[🤍] N/A" end

			local percentage, charging

			if is_mac then
				-- Example mac output:
				-- Now drawing from 'Battery Power'
				--  -InternalBattery-0 (id=1234567)    89%; discharging; (no estimate) present: true
				percentage = tonumber(result:match("(%d?%d?%d)%%"))
				charging = result:match("charging") or result:match("AC Power")
			else
				-- Example linux output (acpi):
				-- Battery 0: Discharging, 89%, 01:45:12 remaining
				percentage = tonumber(result:match("(%d?%d?%d)%%"))
				charging = result:match("Charging")
			end

			if not percentage then return "[🤍] N/A" end

			local total_hearts = 5
			local filled_hearts = math.floor(percentage / 100 * total_hearts)
			local empty_hearts = total_hearts - filled_hearts

			local bar = "[" .. string.rep("🩷", filled_hearts) .. string.rep("🤍", empty_hearts) .. "]"

			local status_icon = charging and "+" or "-"

			return string.format("%s%s%d%%%%⚡", bar, status_icon, percentage)
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
