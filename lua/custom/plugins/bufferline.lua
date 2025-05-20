return {
	'akinsho/bufferline.nvim',
	version = "*", 
	dependencies = {'nvim-tree/nvim-web-devicons'},
	},
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers", -- shows buffers like VSCode tabs
				separator_style = "slant", -- "slant", "thick", "thin", "padded_slant"
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = false,
				enforce_regular_tabs = false,
				always_show_bufferline = true,
			},
		})
	end,
} 
