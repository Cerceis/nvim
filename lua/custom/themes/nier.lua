-- ╔══════════════════════════════════════════════════════╗
-- ║  NieR:Automata Dark — Neovim Colorscheme            ║
-- ╚══════════════════════════════════════════════════════╝
--
-- A dark theme inspired by the YoRHa terminal interfaces.
-- Designed for deep blacks, warm cream text, and muted earth tones.

local M = {}

function M.setup()
	-- Reset
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.o.termguicolors = true
	vim.g.colors_name = "nier"

	local hl = function(group, opts)
		vim.api.nvim_set_hl(0, group, opts)
	end

	-- ── Palette ──
	local c = {
		bg        = "#0a0a0c",
		bg1       = "#111113",
		bg2       = "#1a1a1e",
		bg3       = "#222226",
		bg4       = "#2a2a2e",
		fg        = "#DAD4BB",
		fg_dim    = "#978B6E",
		fg_dark   = "#6B6352",
		cream     = "#C8C2A2",
		gold      = "#B4A882",
		red       = "#8B4545",
		red_light = "#A65454",
		green     = "#7A8B69",
		green_l   = "#94A67E",
		yellow    = "#B4A882",
		blue      = "#5A6B7A",
		blue_l    = "#7088A0",
		purple    = "#8B7088",
		purple_l  = "#A6889E",
		cyan      = "#6B8B8B",
		cyan_l    = "#88ABAB",
		border    = "#3d3d42",
		selection = "#2a2820",
		visual    = "#3a3528",
		none      = "NONE",
	}

	-- ── Editor ──
	hl("Normal",        { fg = c.fg,      bg = c.none })
	hl("NormalNC",      { fg = c.fg_dim,  bg = c.none })
	hl("NormalFloat",   { fg = c.fg,      bg = c.bg1 })
	hl("FloatBorder",   { fg = c.border,  bg = c.bg1 })
	hl("FloatTitle",    { fg = c.gold,    bg = c.bg1, bold = true })
	hl("Cursor",        { fg = c.bg,      bg = c.fg })
	hl("CursorLine",    { bg = c.bg2 })
	hl("CursorColumn",  { bg = c.bg2 })
	hl("ColorColumn",   { bg = c.bg2 })
	hl("LineNr",        { fg = c.fg_dark })
	hl("CursorLineNr",  { fg = c.gold, bold = true })
	hl("SignColumn",    { fg = c.fg_dark, bg = c.none })
	hl("VertSplit",     { fg = c.border })
	hl("WinSeparator",  { fg = c.border })
	hl("StatusLine",    { fg = c.fg,     bg = c.bg2 })
	hl("StatusLineNC",  { fg = c.fg_dark, bg = c.bg1 })
	hl("TabLine",       { fg = c.fg_dim, bg = c.bg1 })
	hl("TabLineFill",   { bg = c.bg })
	hl("TabLineSel",    { fg = c.gold,   bg = c.bg3, bold = true })
	hl("Pmenu",         { fg = c.fg,     bg = c.bg2 })
	hl("PmenuSel",      { fg = c.bg,     bg = c.gold })
	hl("PmenuSbar",     { bg = c.bg3 })
	hl("PmenuThumb",    { bg = c.fg_dark })
	hl("Visual",        { bg = c.visual })
	hl("VisualNOS",     { bg = c.visual })
	hl("Search",        { fg = c.bg, bg = c.gold })
	hl("IncSearch",     { fg = c.bg, bg = c.cream })
	hl("CurSearch",     { fg = c.bg, bg = c.gold, bold = true })
	hl("Folded",        { fg = c.fg_dim, bg = c.bg2 })
	hl("FoldColumn",    { fg = c.fg_dark })
	hl("MatchParen",    { fg = c.gold, bg = c.bg4, bold = true })
	hl("NonText",       { fg = c.bg4 })
	hl("SpecialKey",    { fg = c.bg4 })
	hl("Whitespace",    { fg = c.bg3 })
	hl("EndOfBuffer",   { fg = c.bg2 })
	hl("Directory",     { fg = c.gold })
	hl("Title",         { fg = c.gold, bold = true })
	hl("ErrorMsg",      { fg = c.red_light })
	hl("WarningMsg",    { fg = c.yellow })
	hl("MoreMsg",       { fg = c.green })
	hl("Question",      { fg = c.gold })
	hl("WildMenu",      { fg = c.bg, bg = c.gold })
	hl("Conceal",       { fg = c.fg_dark })
	hl("WinBar",        { fg = c.fg, bold = true })
	hl("WinBarNC",      { fg = c.fg_dim })

	-- ── Syntax ──
	hl("Comment",     { fg = c.fg_dark, italic = true })
	hl("Constant",    { fg = c.cream })
	hl("String",      { fg = c.green_l })
	hl("Character",   { fg = c.green })
	hl("Number",      { fg = c.purple_l })
	hl("Boolean",     { fg = c.gold, bold = true })
	hl("Float",       { fg = c.purple_l })
	hl("Identifier",  { fg = c.fg })
	hl("Function",    { fg = c.cream, bold = true })
	hl("Statement",   { fg = c.gold })
	hl("Conditional", { fg = c.gold })
	hl("Repeat",      { fg = c.gold })
	hl("Label",       { fg = c.gold })
	hl("Operator",    { fg = c.fg_dim })
	hl("Keyword",     { fg = c.gold, bold = true })
	hl("Exception",   { fg = c.red_light })
	hl("PreProc",     { fg = c.cyan })
	hl("Include",     { fg = c.cyan })
	hl("Define",      { fg = c.cyan })
	hl("Macro",       { fg = c.cyan_l })
	hl("PreCondit",   { fg = c.cyan })
	hl("Type",        { fg = c.cream })
	hl("StorageClass",{ fg = c.gold })
	hl("Structure",   { fg = c.cream })
	hl("Typedef",     { fg = c.cream })
	hl("Special",     { fg = c.purple })
	hl("SpecialChar", { fg = c.purple_l })
	hl("Tag",         { fg = c.gold })
	hl("Delimiter",   { fg = c.fg_dim })
	hl("Debug",       { fg = c.red })
	hl("Underlined",  { fg = c.blue_l, underline = true })
	hl("Error",       { fg = c.red_light })
	hl("Todo",        { fg = c.bg, bg = c.gold, bold = true })

	-- ── Diagnostics ──
	hl("DiagnosticError",          { fg = c.red_light })
	hl("DiagnosticWarn",           { fg = c.yellow })
	hl("DiagnosticInfo",           { fg = c.blue_l })
	hl("DiagnosticHint",           { fg = c.fg_dim })
	hl("DiagnosticUnderlineError", { sp = c.red_light, undercurl = true })
	hl("DiagnosticUnderlineWarn",  { sp = c.yellow,    undercurl = true })
	hl("DiagnosticUnderlineInfo",  { sp = c.blue_l,    undercurl = true })
	hl("DiagnosticUnderlineHint",  { sp = c.fg_dim,    undercurl = true })

	-- ── Git Signs ──
	hl("GitSignsAdd",    { fg = c.green })
	hl("GitSignsChange", { fg = c.blue_l })
	hl("GitSignsDelete", { fg = c.red })
	hl("DiffAdd",        { bg = "#1a2218" })
	hl("DiffChange",     { bg = "#1a1e22" })
	hl("DiffDelete",     { bg = "#221818" })
	hl("DiffText",       { bg = "#2a2e34" })

	-- ── Treesitter ──
	hl("@variable",           { fg = c.fg })
	hl("@variable.builtin",   { fg = c.purple })
	hl("@variable.parameter", { fg = c.fg, italic = true })
	hl("@constant",           { fg = c.cream })
	hl("@constant.builtin",   { fg = c.purple_l })
	hl("@module",             { fg = c.cream })
	hl("@string",             { fg = c.green_l })
	hl("@string.escape",      { fg = c.cyan })
	hl("@character",          { fg = c.green })
	hl("@number",             { fg = c.purple_l })
	hl("@boolean",            { fg = c.gold, bold = true })
	hl("@type",               { fg = c.cream })
	hl("@type.builtin",       { fg = c.cream, italic = true })
	hl("@attribute",          { fg = c.gold })
	hl("@property",           { fg = c.fg })
	hl("@function",           { fg = c.cream, bold = true })
	hl("@function.builtin",   { fg = c.cream })
	hl("@function.call",      { fg = c.cream })
	hl("@function.method",    { fg = c.cream })
	hl("@constructor",        { fg = c.gold })
	hl("@keyword",            { fg = c.gold, bold = true })
	hl("@keyword.function",   { fg = c.gold })
	hl("@keyword.return",     { fg = c.gold, italic = true })
	hl("@keyword.operator",   { fg = c.fg_dim })
	hl("@operator",           { fg = c.fg_dim })
	hl("@punctuation",        { fg = c.fg_dim })
	hl("@punctuation.bracket", { fg = c.fg_dim })
	hl("@punctuation.delimiter", { fg = c.fg_dim })
	hl("@comment",            { fg = c.fg_dark, italic = true })
	hl("@tag",                { fg = c.gold })
	hl("@tag.attribute",      { fg = c.cream, italic = true })
	hl("@tag.delimiter",      { fg = c.fg_dim })
	hl("@markup.heading",     { fg = c.gold, bold = true })
	hl("@markup.link",        { fg = c.blue_l, underline = true })
	hl("@markup.strong",      { bold = true })
	hl("@markup.italic",      { italic = true })

	-- ── LSP Semantic Tokens ──
	hl("@lsp.type.namespace",  { fg = c.cream })
	hl("@lsp.type.type",       { fg = c.cream })
	hl("@lsp.type.class",      { fg = c.cream })
	hl("@lsp.type.enum",       { fg = c.cream })
	hl("@lsp.type.interface",  { fg = c.cream, italic = true })
	hl("@lsp.type.struct",     { fg = c.cream })
	hl("@lsp.type.parameter",  { fg = c.fg, italic = true })
	hl("@lsp.type.property",   { fg = c.fg })
	hl("@lsp.type.function",   { fg = c.cream, bold = true })
	hl("@lsp.type.method",     { fg = c.cream })
	hl("@lsp.type.macro",      { fg = c.cyan_l })
	hl("@lsp.type.decorator",  { fg = c.gold })

	-- ── Telescope ──
	hl("TelescopeNormal",         { fg = c.fg, bg = c.bg1 })
	hl("TelescopeBorder",         { fg = c.border, bg = c.bg1 })
	hl("TelescopeTitle",          { fg = c.gold, bold = true })
	hl("TelescopePromptNormal",   { fg = c.fg, bg = c.bg2 })
	hl("TelescopePromptBorder",   { fg = c.border, bg = c.bg2 })
	hl("TelescopePromptTitle",    { fg = c.bg, bg = c.gold, bold = true })
	hl("TelescopePromptPrefix",   { fg = c.gold, bg = c.bg2 })
	hl("TelescopeResultsNormal",  { fg = c.fg, bg = c.bg1 })
	hl("TelescopeResultsBorder",  { fg = c.border, bg = c.bg1 })
	hl("TelescopePreviewNormal",  { fg = c.fg, bg = c.bg })
	hl("TelescopePreviewBorder",  { fg = c.border, bg = c.bg })
	hl("TelescopePreviewTitle",   { fg = c.gold })
	hl("TelescopeSelection",      { bg = c.bg3 })
	hl("TelescopeSelectionCaret",  { fg = c.gold })
	hl("TelescopeMatching",       { fg = c.gold, bold = true })

	-- ── Indent Blankline ──
	hl("IblIndent",   { fg = c.bg3 })
	hl("IblScope",    { fg = c.border })

	-- ── Bufferline ──
	hl("BufferLineFill",       { bg = c.bg })
	hl("BufferLineBackground", { fg = c.fg_dark, bg = c.bg1 })
	hl("BufferLineSelected",   { fg = c.gold, bg = c.bg, bold = true })

	-- ── Neo-tree ──
	hl("NeoTreeNormal",       { fg = c.fg, bg = c.bg })
	hl("NeoTreeNormalNC",     { fg = c.fg_dim, bg = c.bg })
	hl("NeoTreeDirectoryName", { fg = c.gold })
	hl("NeoTreeDirectoryIcon", { fg = c.gold })
	hl("NeoTreeFileName",     { fg = c.fg })
	hl("NeoTreeGitAdded",     { fg = c.green })
	hl("NeoTreeGitModified",  { fg = c.blue_l })
	hl("NeoTreeGitDeleted",   { fg = c.red })
	hl("NeoTreeIndentMarker", { fg = c.bg4 })
	hl("NeoTreeRootName",     { fg = c.gold, bold = true })

	-- ── Alpha (Dashboard) ──
	hl("AlphaHeader",   { fg = c.gold })
	hl("AlphaButtons",  { fg = c.cream })
	hl("AlphaShortcut", { fg = c.fg_dim })
	hl("BabyBlue",      { fg = c.gold })
	hl("PastelPink",    { fg = c.fg_dark })

	-- ── Which Key ──
	hl("WhichKey",          { fg = c.gold })
	hl("WhichKeyGroup",     { fg = c.cream })
	hl("WhichKeyDesc",      { fg = c.fg })
	hl("WhichKeySeparator", { fg = c.fg_dark })
	hl("WhichKeyValue",     { fg = c.fg_dim })

	-- ── Mini ──
	hl("MiniStatuslineModeNormal",  { fg = c.bg, bg = c.gold, bold = true })
	hl("MiniStatuslineModeInsert",  { fg = c.bg, bg = c.green, bold = true })
	hl("MiniStatuslineModeVisual",  { fg = c.bg, bg = c.purple, bold = true })
	hl("MiniStatuslineModeCommand", { fg = c.bg, bg = c.red, bold = true })
end

return M
