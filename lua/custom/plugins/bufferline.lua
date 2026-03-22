return {
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = {'nvim-tree/nvim-web-devicons'},
	config = function()
		require("bufferline").setup({
			options = {
				numbers = function(opts)
					return string.format("▫%s", opts.ordinal)
				end,
				mode = "buffers",
				separator_style = "slant",
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				close_icon = "✕",
				modified_icon = "◇",
				left_trunc_marker = "◁",
				right_trunc_marker = "▷",
				show_close_icon = false,
				enforce_regular_tabs = false,
				always_show_bufferline = true,
				indicator = {
					icon = "▎",
					style = "icon",
				},
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level)
					local icons = { error = "E", warning = "W", hint = "H", info = "I" }
					return (icons[level] or "?") .. count
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "-- File Tree --",
						text_align = "center",
						separator = true,
					},
				},
			},
			highlights = {
				fill = { bg = "#0a0a0c" },
				background = { fg = "#6B6352", bg = "#111113" },
				buffer_selected = { fg = "#B4A882", bg = "#0a0a0c", bold = true, italic = false },
				buffer_visible = { fg = "#978B6E", bg = "#111113" },
				close_button = { fg = "#6B6352", bg = "#111113" },
				close_button_selected = { fg = "#CC5555", bg = "#0a0a0c" },
				modified = { fg = "#D4C878", bg = "#111113" },
				modified_selected = { fg = "#D4C878", bg = "#0a0a0c" },
				separator = { fg = "#0a0a0c", bg = "#111113" },
				separator_selected = { fg = "#0a0a0c", bg = "#0a0a0c" },
				indicator_selected = { fg = "#B4A882", bg = "#0a0a0c" },
				numbers = { fg = "#6B6352", bg = "#111113" },
				numbers_selected = { fg = "#B4A882", bg = "#0a0a0c", bold = true },
				diagnostic = { fg = "#6B6352", bg = "#111113" },
				diagnostic_selected = { fg = "#B4A882", bg = "#0a0a0c" },
				error = { fg = "#CC5555", bg = "#111113" },
				error_selected = { fg = "#E06868", bg = "#0a0a0c" },
				warning = { fg = "#D4C878", bg = "#111113" },
				warning_selected = { fg = "#D4C878", bg = "#0a0a0c" },
				offset_separator = { fg = "#3d3d42", bg = "#0a0a0c" },
			},
		})
	end,
}
