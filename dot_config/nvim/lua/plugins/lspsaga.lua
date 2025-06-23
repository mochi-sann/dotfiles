return {
	"nvimdev/lspsaga.nvim",
	config = function()
		require("lspsaga").setup({})
		vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
		vim.keymap.set("n", "<space>gf", "<cmd>Lspsaga lsp_finder<CR>")
		vim.keymap.set("n", "<space>gd", "<cmd>Lspsaga peek_definition<CR>")
		vim.keymap.set("n", "<space>gca", "<cmd>Lspsaga code_action<CR>")
		vim.keymap.set("n", "<space>grn", "<cmd>Lspsaga rename<CR>")
		vim.keymap.set("n", "<space>ge", "<cmd>Lspsaga show_line_diagnostics<CR>")
		vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
		vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")

		-- vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>")
		-- -- vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>")
		-- vim.keymap.set("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]])
	end,
}
