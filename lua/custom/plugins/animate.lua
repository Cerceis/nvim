-- +----------------------------------------------+
-- |  YoRHa Motion Control -- Animations          |
-- +----------------------------------------------+
return {
	"echasnovski/mini.animate",
	event = "VeryLazy",
	config = function()
		local animate = require("mini.animate")

		animate.setup({
			-- Smooth cursor movement
			cursor = {
				enable = true,
				timing = animate.gen_timing.cubic({ duration = 80, unit = "total" }),
			},
			-- Scrolling — disabled, feels slow on jumps
			scroll = {
				enable = false,
			},
			-- Window resize animation
			resize = {
				enable = true,
				timing = animate.gen_timing.cubic({ duration = 80, unit = "total" }),
			},
			-- Window open animation
			open = {
				enable = true,
				timing = animate.gen_timing.cubic({ duration = 80, unit = "total" }),
			},
			-- Window close animation
			close = {
				enable = true,
				timing = animate.gen_timing.cubic({ duration = 80, unit = "total" }),
			},
		})
	end,
}
