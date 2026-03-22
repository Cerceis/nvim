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
		fg_dim    = "#A09880",
		fg_dark   = "#787060",
		cream     = "#C8C2A2",
		gold      = "#B4A882",
		red       = "#CC5555",
		red_light = "#E06868",
		green     = "#50C878",       -- pushed cool — minty, clearly not yellow
		green_l   = "#70E890",       -- bright cool green for strings
		yellow    = "#D4C878",
		blue      = "#5A98D0",
		blue_l    = "#78B8F0",
		purple    = "#B868C0",
		purple_l  = "#D888E0",
		cyan      = "#48B8B8",
		cyan_l    = "#68DCD8",
		border    = "#4a4a52",       -- brighter for window separation
		selection = "#2a2820",
		visual    = "#3d3828",       -- more visible selection
		none      = "NONE",
	}

	-- ── Editor ──
	hl("Normal",        { fg = c.fg,      bg = c.none })
	hl("NormalNC",      { fg = c.cream,   bg = c.none })
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

	-- ── Syntax (vim legacy groups — fallback for non-treesitter) ──
	hl("Comment",     { fg = c.fg_dark, italic = true })
	hl("Constant",    { fg = c.yellow })
	hl("String",      { fg = c.green_l })
	hl("Character",   { fg = c.green })
	hl("Number",      { fg = c.purple_l })
	hl("Boolean",     { fg = c.purple_l, bold = true })
	hl("Float",       { fg = c.purple_l })
	hl("Identifier",  { fg = c.fg })
	hl("Function",    { fg = c.blue_l, bold = true })
	hl("Statement",   { fg = c.purple })
	hl("Conditional", { fg = c.purple })
	hl("Repeat",      { fg = c.purple })
	hl("Label",       { fg = c.purple })
	hl("Operator",    { fg = c.cyan })
	hl("Keyword",     { fg = c.purple, bold = true })
	hl("Exception",   { fg = c.red_light })
	hl("PreProc",     { fg = c.cyan })
	hl("Include",     { fg = c.purple })
	hl("Define",      { fg = c.cyan })
	hl("Macro",       { fg = c.cyan_l })
	hl("PreCondit",   { fg = c.cyan })
	hl("Type",        { fg = c.yellow })
	hl("StorageClass",{ fg = c.purple })
	hl("Structure",   { fg = c.yellow })
	hl("Typedef",     { fg = c.yellow })
	hl("Special",     { fg = c.red_light })
	hl("SpecialChar", { fg = c.cyan })
	hl("Tag",         { fg = c.blue })
	hl("Delimiter",   { fg = c.fg_dim })
	hl("Debug",       { fg = c.red })
	hl("Underlined",  { fg = c.blue_l, underline = true })
	hl("Error",       { fg = c.red_light })
	hl("Todo",        { fg = c.bg, bg = c.gold, bold = true })

	-- ── Diagnostics ──
	hl("DiagnosticError",          { fg = c.red_light })
	hl("DiagnosticWarn",           { fg = c.yellow })
	hl("DiagnosticInfo",           { fg = c.blue_l })
	hl("DiagnosticHint",           { fg = c.cyan })
	hl("DiagnosticUnnecessary",    { fg = c.fg_dark, italic = true })
	hl("DiagnosticDeprecated",     { fg = c.fg_dark, strikethrough = true })
	hl("DiagnosticUnderlineError", { sp = c.red_light, undercurl = true })
	hl("DiagnosticUnderlineWarn",  { sp = c.yellow,    undercurl = true })
	hl("DiagnosticUnderlineInfo",  { sp = c.blue_l,    undercurl = true })
	hl("DiagnosticUnderlineHint",  { sp = c.cyan,      undercurl = true })

	-- ── Git Signs ──
	hl("GitSignsAdd",    { fg = c.green })
	hl("GitSignsChange", { fg = c.blue_l })
	hl("GitSignsDelete", { fg = c.red })
	hl("DiffAdd",        { bg = "#1a2416" })
	hl("DiffChange",     { bg = "#161e28" })
	hl("DiffDelete",     { bg = "#281616" })
	hl("DiffText",       { bg = "#2a2e34" })

	-- ── Treesitter ──
	-- Variables & identifiers
	hl("@variable",           { fg = c.fg })
	hl("@variable.builtin",   { fg = c.red_light })
	hl("@variable.parameter", { fg = c.red_light, italic = true })
	hl("@variable.member",    { fg = c.cyan })
	hl("@constant",           { fg = c.yellow })
	hl("@constant.builtin",   { fg = c.purple_l })
	hl("@module",             { fg = c.gold })

	-- Literals
	hl("@string",             { fg = c.green_l })
	hl("@string.documentation", { fg = c.green })
	hl("@string.escape",      { fg = c.cyan })
	hl("@string.regexp",      { fg = c.cyan_l })
	hl("@string.special.url", { fg = c.blue_l, underline = true })
	hl("@character",          { fg = c.green })
	hl("@number",             { fg = c.purple_l })
	hl("@boolean",            { fg = c.purple_l, bold = true })

	-- Types
	hl("@type",               { fg = c.yellow })
	hl("@type.builtin",       { fg = c.purple, italic = true })
	hl("@type.qualifier",     { fg = c.purple })
	hl("@attribute",          { fg = c.yellow })

	-- Properties & fields
	hl("@property",           { fg = c.cyan })

	-- Functions
	hl("@function",           { fg = c.blue_l, bold = true })
	hl("@function.builtin",   { fg = c.cyan_l })
	hl("@function.call",      { fg = c.blue_l })
	hl("@function.method",    { fg = c.blue_l })
	hl("@function.method.call", { fg = c.blue_l })
	hl("@function.macro",     { fg = c.cyan_l })
	hl("@constructor",        { fg = c.yellow })

	-- Keywords & control flow
	hl("@keyword",            { fg = c.purple, bold = true })
	hl("@keyword.function",   { fg = c.purple })
	hl("@keyword.return",     { fg = c.purple, italic = true })
	hl("@keyword.operator",   { fg = c.purple })
	hl("@keyword.import",     { fg = c.purple })
	hl("@keyword.repeat",     { fg = c.purple })
	hl("@keyword.conditional", { fg = c.purple })
	hl("@keyword.exception",  { fg = c.red_light })

	-- Operators & punctuation
	hl("@operator",           { fg = c.cyan })
	hl("@punctuation",        { fg = c.fg_dim })
	hl("@punctuation.bracket", { fg = c.fg })
	hl("@punctuation.delimiter", { fg = c.fg_dim })
	hl("@punctuation.special", { fg = c.cyan })

	-- Comments
	hl("@comment",            { fg = c.fg_dark, italic = true })
	hl("@comment.documentation", { fg = c.fg_dark, italic = true })

	-- Tags (HTML/JSX)
	hl("@tag",                { fg = c.blue })
	hl("@tag.builtin",        { fg = c.blue })
	hl("@tag.attribute",      { fg = c.yellow, italic = true })
	hl("@tag.delimiter",      { fg = c.cyan })

	-- Markup
	hl("@markup.heading",     { fg = c.gold, bold = true })
	hl("@markup.link",        { fg = c.blue_l, underline = true })
	hl("@markup.link.url",    { fg = c.blue_l, underline = true })
	hl("@markup.strong",      { fg = c.red_light, bold = true })
	hl("@markup.italic",      { italic = true })
	hl("@markup.raw",         { fg = c.green_l })
	hl("@markup.list",        { fg = c.cyan })

	-- ── LSP Semantic Tokens ──
	hl("@lsp.type.namespace",  { fg = c.gold })
	hl("@lsp.type.type",       { fg = c.yellow })
	hl("@lsp.type.class",      { fg = c.yellow })
	hl("@lsp.type.enum",       { fg = c.yellow })
	hl("@lsp.type.interface",  { fg = c.yellow, italic = true })
	hl("@lsp.type.struct",     { fg = c.yellow })
	hl("@lsp.type.parameter",  { fg = c.red_light, italic = true })
	hl("@lsp.type.property",   { fg = c.cyan })
	hl("@lsp.type.function",   { fg = c.blue_l, bold = true })
	hl("@lsp.type.method",     { fg = c.blue_l })
	hl("@lsp.type.macro",      { fg = c.cyan_l })
	hl("@lsp.type.decorator",  { fg = c.yellow })
	hl("@lsp.type.variable",   { }) -- defer to treesitter
	hl("@lsp.mod.deprecated",  { fg = c.fg_dark, strikethrough = true })
	hl("@lsp.mod.readonly",    { bold = true })
	hl("@lsp.mod.unused",      { fg = c.fg_dark, italic = true })
	hl("@lsp.typemod.variable.readonly", { fg = c.yellow })
	hl("@lsp.typemod.function.defaultLibrary", { fg = c.cyan_l })
	hl("@lsp.typemod.type.defaultLibrary", { fg = c.purple, italic = true })
	hl("@lsp.typemod.class.defaultLibrary", { fg = c.purple, italic = true })

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
	hl("MiniAnimateCursor",         { reverse = true })

	-- ── Noice ──
	hl("NoiceCmdline",          { fg = c.fg, bg = c.bg1 })
	hl("NoiceCmdlineIcon",      { fg = c.gold })
	hl("NoiceCmdlineIconSearch", { fg = c.cyan_l })
	hl("NoiceCmdlinePopup",     { fg = c.fg, bg = c.bg1 })
	hl("NoiceCmdlinePopupBorder", { fg = c.border, bg = c.bg1 })
	hl("NoiceCmdlinePopupTitle",  { fg = c.gold, bg = c.bg1, bold = true })
	hl("NoiceConfirm",          { fg = c.fg, bg = c.bg2 })
	hl("NoiceConfirmBorder",    { fg = c.gold, bg = c.bg2 })
	hl("NoiceMini",             { fg = c.fg_dim, bg = c.bg2 })
	hl("NoiceFormatProgressDone", { fg = c.bg, bg = c.gold })
	hl("NoiceFormatProgressTodo", { fg = c.fg_dim, bg = c.bg3 })
	hl("NoiceLspProgressTitle",   { fg = c.gold })
	hl("NoiceLspProgressClient",  { fg = c.cream })
	hl("NoiceLspProgressSpinner", { fg = c.cyan_l })
	hl("NoiceVirtualText",     { fg = c.gold })

	-- ── Notify ──
	hl("NotifyERRORBorder", { fg = c.red })
	hl("NotifyWARNBorder",  { fg = c.yellow })
	hl("NotifyINFOBorder",  { fg = c.cyan })
	hl("NotifyDEBUGBorder", { fg = c.fg_dark })
	hl("NotifyTRACEBorder", { fg = c.purple })
	hl("NotifyERRORIcon",   { fg = c.red_light })
	hl("NotifyWARNIcon",    { fg = c.yellow })
	hl("NotifyINFOIcon",    { fg = c.cyan_l })
	hl("NotifyDEBUGIcon",   { fg = c.fg_dim })
	hl("NotifyTRACEIcon",   { fg = c.purple_l })
	hl("NotifyERRORTitle",  { fg = c.red_light, bold = true })
	hl("NotifyWARNTitle",   { fg = c.yellow, bold = true })
	hl("NotifyINFOTitle",   { fg = c.cyan_l, bold = true })
	hl("NotifyDEBUGTitle",  { fg = c.fg_dim })
	hl("NotifyTRACETitle",  { fg = c.purple_l })
	hl("NotifyERRORBody",   { fg = c.fg })
	hl("NotifyWARNBody",    { fg = c.fg })
	hl("NotifyINFOBody",    { fg = c.fg })
	hl("NotifyDEBUGBody",   { fg = c.fg_dim })
	hl("NotifyTRACEBody",   { fg = c.fg_dim })
	hl("NotifyBackground",  { bg = c.bg1 })

	-- ── Dropbar ──
	hl("DropBarIconKindFile",     { fg = c.fg })
	hl("DropBarIconKindFolder",   { fg = c.gold })
	hl("DropBarIconKindFunction", { fg = c.blue_l, bold = true })
	hl("DropBarIconKindMethod",   { fg = c.blue_l })
	hl("DropBarIconKindClass",    { fg = c.yellow })
	hl("DropBarMenuCurrentContext", { bg = c.bg3 })
	hl("DropBarCurrentContext",   { fg = c.gold, bold = true })
	hl("DropBarPreview",          { bg = c.bg2 })

	-- ── Dressing ──
	hl("DressingInput",       { fg = c.fg, bg = c.bg2 })
	hl("DressingInputBorder", { fg = c.gold })
	hl("DressingSelect",      { fg = c.fg, bg = c.bg2 })
	hl("DressingSelectBorder", { fg = c.gold })
end

return M
