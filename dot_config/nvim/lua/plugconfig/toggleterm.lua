local Terminal = require("toggleterm.terminal").Terminal
require("toggleterm").setup({
	open_mapping = [[<c-t>]],

	size = 100,
	direction = "float",
	hide_numbers = false,
	float_opts = { winblend = 0, border = "curved" },
})
-- vim.api.nvim_set_keymap("n", "<A-t>", "ToggleTerm size=40 direction=horizontal", { noremap = true, silent = true })
-- vim.cmd([[
--
-- autocmd TermEnter term://*toggleterm#*
--       \ tnoremap <silent><c-y> <Cmd>exe v:count1 . "ToggleTerm size=14 direction=horizontal"<CR>
--
-- nnoremap <silent><c-y> <Cmd>exe v:count1 . "ToggleTerm size=14 direction=horizontal"<CR>
-- inoremap <silent><c-y> <Esc><Cmd>exe v:count1 . "ToggleTerm size=14 direction=horizontal"<CR>
-- ]])
function get_current_buf_dir()
	return vim.fn.expand("%:p:h")
end

local current_buf_dir = get_current_buf_dir()
-- noremap("t", "<A-t>", "ToggleTerm dir=" + get_current_buf_dir(), { silent = true })
vim.keymap.set("n", "<Space>t", function()
	local current_buf_term = Terminal:new({ dir = vim.fn.expand("%:p:h") })
	current_buf_term:toggle()
end)
