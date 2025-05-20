return{
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = function()
			local autopairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")

			autopairs.setup()

			-- Add custom rule for angle brackets
			autopairs.add_rule(Rule("<", ">"))
		end,
	},
}
