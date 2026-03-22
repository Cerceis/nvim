-- +----------------------------------------------+
-- |  YoRHa Input Terminal -- Dressing UI         |
-- +----------------------------------------------+
return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	opts = {
		input = {
			enabled = true,
			default_prompt = "> Input: ",
			title_pos = "center",
			border = "rounded",
			relative = "editor",
			prefer_width = 50,
			min_width = 30,
			win_options = {
				winblend = 0,
				winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,FloatTitle:FloatTitle",
			},
			mappings = {
				n = { ["<Esc>"] = "Close", ["<CR>"] = "Confirm" },
				i = { ["<C-c>"] = "Close", ["<CR>"] = "Confirm", ["<C-k>"] = "HistoryPrev", ["<C-j>"] = "HistoryNext" },
			},
		},
		select = {
			enabled = true,
			backend = { "telescope", "builtin" },
			trim_prompt = true,
			builtin = {
				border = "rounded",
				relative = "editor",
				win_options = {
					winblend = 0,
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,FloatTitle:FloatTitle",
				},
			},
		},
	},
}
