return {
	'alyxshang/menhera.nvim',
	dependencies = {
		{
			'alyxshang/guizhong.nvim',
			version = "v.0.3.0"
		}
	},
	config = function()

		-- Setting the transparency setting.
		-- Can be set to "true" or "false".

		require("menhera").setup({ transparent = true })
		vim.cmd.colorscheme("menhera")

		require("custom.themes.extra-theme-settings")
	end
}
