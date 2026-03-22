-- +----------------------------------------------+
-- |  YoRHa Tactical Interface -- Noice UI        |
-- +----------------------------------------------+
return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	opts = {
		cmdline = {
			enabled = true,
			view = "cmdline_popup",
			format = {
				cmdline = { pattern = "^:", icon = " > ", lang = "vim", title = " Command " },
				search_down = { kind = "search", pattern = "^/", icon = " o Search ", lang = "regex", title = " Search v " },
				search_up = { kind = "search", pattern = "^%?", icon = " o Search ", lang = "regex", title = " Search ^ " },
				filter = { pattern = "^:%s*!", icon = " + ", lang = "bash", title = " Terminal " },
				lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = " o ", lang = "lua", title = " Lua " },
				help = { pattern = "^:%s*he?l?p?%s+", icon = " # Help ", title = " Help " },
				substitute = { pattern = "^:%%?s/", icon = " < Replace ", lang = "regex", title = " Replace " },
			},
		},
		messages = {
			enabled = true,
			view = "notify",
			view_error = "notify",
			view_warn = "notify",
			view_history = "messages",
			view_search = "virtualtext",
		},
		popupmenu = {
			enabled = true,
			backend = "nui",
		},
		lsp = {
			progress = {
				enabled = true,
				format = {
					{ "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
					{ "({data.progress.percentage}%) ", hl_group = "NoiceLspProgressSpinner" },
					{ "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
				},
			},
			hover = { enabled = true },
			signature = { enabled = true },
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		presets = {
			bottom_search = false,
			command_palette = true,
			long_message_to_split = true,
			lsp_doc_border = true,
		},
		views = {
			cmdline_popup = {
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				position = { row = "40%", col = "50%" },
				size = { width = 70, height = "auto" },
				win_options = {
					winhighlight = "NormalFloat:NoiceCmdlinePopup,FloatBorder:NoiceCmdlinePopupBorder,FloatTitle:NoiceCmdlinePopupTitle",
				},
			},
			popupmenu = {
				relative = "editor",
				position = { row = "48%", col = "50%" },
				size = { width = 70, height = 10 },
				border = { style = "rounded", padding = { 0, 1 } },
			},
			hover = {
				border = { style = "rounded" },
				position = { row = 2, col = 2 },
			},
		},
		routes = {
			-- Skip "written" messages
			{ filter = { event = "msg_show", kind = "", find = "written" }, opts = { skip = true } },
			-- Skip search count messages (shown in virtualtext)
			{ filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },
		},
	},
}
