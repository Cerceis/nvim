-- Extra palette and theme related settings, must be loaded after your theme
-- defining color scheme.

-- Make background transparent to respect kitty's opacity
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })

-- NieR palette custom highlights
vim.api.nvim_set_hl(0, "LineNr", { fg = "#978B6E", bg = "NONE" })
vim.api.nvim_set_hl(0, "BabyBlue", { fg = "#B4A882" })
vim.api.nvim_set_hl(0, "PastelPink", { fg = "#6B6352" })
vim.api.nvim_set_hl(0, "Lilac", { fg = "#8B7088" })

