local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}

local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#913f45" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#7c6741" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#2d506f" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#9e744d" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#789a60" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#8d559d" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#45929c" })
end)

require("ibl").setup({
	indent = {
		char = "▎",
		tab_char = "▎",
		highlight = highlight,
	},
})
