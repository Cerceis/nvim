-- +----------------------------------------------+
-- |  YoRHa Path Display -- Dropbar Breadcrumbs   |
-- +----------------------------------------------+
return {
	"Bekaboo/dropbar.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		icons = {
			kinds = {
				symbols = {
					Array = "o ",
					Boolean = "# ",
					Class = "+ ",
					Color = "o ",
					Constant = "* ",
					Constructor = "> ",
					Enum = "o ",
					EnumMember = "o ",
					Event = "! ",
					Field = "- ",
					File = ". ",
					Folder = "> ",
					Function = "> ",
					Interface = "< ",
					Key = "= ",
					Keyword = "# ",
					Method = "> ",
					Module = "@ ",
					Namespace = "@ ",
					Null = "0 ",
					Number = "# ",
					Object = "o ",
					Operator = "+ ",
					Package = "@ ",
					Property = "- ",
					Reference = "-> ",
					Snippet = "* ",
					String = "\" ",
					Struct = "+ ",
					Text = "T ",
					TypeParameter = "< ",
					Unit = "U ",
					Value = "= ",
					Variable = "o ",
				},
			},
			ui = {
				bar = {
					separator = "  >  ",
				},
			},
		},
		bar = {
			sources = function(buf, _)
				local sources = require("dropbar.sources")
				local utils = require("dropbar.utils")
				if vim.bo[buf].ft == "markdown" then
					return { sources.path, sources.markdown }
				end
				if vim.bo[buf].buftype == "terminal" then
					return { sources.terminal }
				end
				return { sources.path, utils.source.fallback({ sources.lsp, sources.treesitter }) }
			end,
		},
	},
}
