local auto_dark_mode = require("auto-dark-mode")

auto_dark_mode.setup({
	update_interval = 30000,
	set_dark_mode = function()
		vim.opt.background = "dark"
		vim.cmd("colorscheme dracula")
	end,
	set_light_mode = function()
		-- NOTE: 現状は light でも dark テーマのまま。light を使うなら下のコメントを有効化する
		vim.opt.background = "dark"
		vim.cmd("colorscheme dracula")
		-- vim.opt.background = "light"
		-- vim.cmd("colorscheme PaperColor")
	end,
})
auto_dark_mode.init()
