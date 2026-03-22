-- +----------------------------------------------+
-- |  YoRHa Alert System -- Notify               |
-- +----------------------------------------------+
return {
	"rcarriga/nvim-notify",
	opts = {
		timeout = 3000,
		fps = 60,
		render = "wrapped-compact",
		stages = "fade_in_slide_out",
		max_width = 50,
		max_height = 8,
		minimum_width = 30,
		top_down = true,
		icons = {
			ERROR = "ERR",
			WARN  = "WRN",
			INFO  = "INF",
			DEBUG = "DBG",
			TRACE = "TRC",
		},
		on_open = function(win)
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_set_config(win, { border = "rounded" })
			end
		end,
	},
	config = function(_, opts)
		local notify = require("notify")
		notify.setup(opts)
		vim.notify = notify
	end,
}
