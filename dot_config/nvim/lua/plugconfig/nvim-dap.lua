-- require("neodev").setup({
-- 	library = { plugins = { "nvim-dap-ui" }, types = true },
-- })
--
require("dapui").setup({
	-- アイコン (nard font)
	-- icons = { expanded = "", collapsed = "" },

	-- UIのレイアウトを変更
	-- layouts = {
	-- 	{
	-- 		-- 表示するUI要素
	-- 		elements = {
	-- 			-- それぞれの要素を id で、size に大きさを指定
	-- 			{ id = "repl", size = 0.15 },
	-- 			{ id = "stacks", size = 0.2 },
	-- 			{ id = "watches", size = 0.2 },
	-- 			{ id = "scopes", size = 0.35 },
	-- 			{ id = "breakpoints", size = 0.1 },
	-- 		},
	--
	-- 		-- 横幅の40%の大きさ
	-- 		size = 0.4,
	--
	-- 		-- 画面左側に表示
	-- 		position = "left",
	-- 	},
	--
	-- 	{
	-- 		-- 表示するUI要素、sizeを指定しない場合は文字列だけでok
	-- 		elements = { "console" },
	--
	-- 		-- 縦幅の25%の大きさ
	-- 		size = 0.25,
	--
	-- 		-- 画面下側に表示
	-- 		position = "bottom",
	-- 	},
	-- },
})

vim.api.nvim_set_keymap("n", "<F5>", ":DapContinue<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<F10>", ":DapStepOver<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<F11>", ":DapStepInto<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<F12>", ":DapStepOut<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>b", ":DapToggleBreakpoint<CR>", { silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>B",
	':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint condition: "))<CR>',
	{ silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>lp",
	':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
	{ silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>dr", ':lua require("dap").repl.open()<CR>', { silent = true })
vim.api.nvim_set_keymap("n", "<leader>dl", ':lua require("dap").run_last()<CR>', { silent = true })
vim.api.nvim_set_keymap("n", "<leader>dd", ':lua require("dapui").toggle()<CR>', {})
