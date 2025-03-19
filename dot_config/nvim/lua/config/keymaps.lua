local vim = vim

-- vim.api.nvim_set_keymap("n", "<C-s>", "w", { desc = "Save File" })
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
vim.keymap.set({ "n" }, "U", "<C-r>", { desc = "redo command" })
vim.keymap.set({ "n" }, "p", "]p`]", { desc = "paste and auto indent" })

vim.keymap.set({ "n" }, "P", "]P`]", { desc = "paste before cursor and auto indent" })
vim.keymap.set({ "n" }, "p", "]p`]", { desc = "paste and auto indent" })
vim.keymap.set("n", "<leader>cl", function()
	local path_with_line = vim.fn.expand("%") .. ":" .. vim.fn.line(".")
	vim.fn.setreg("+", path_with_line)
	print("Copied: " .. path_with_line)
end, { desc = "copy relative file path and line number" })

vim.keymap.set("n", "<leader>cf", function()
	local path_with_line = vim.fn.expand("%")
	vim.fn.setreg("+", path_with_line)
	print("Copied: " .. path_with_line)
end, { desc = "copy relative file path" })

vim.cmd([[
" nnoremap U <c-r>  # U でredoになるように

" nnoremap p ]p`]
" nnoremap P ]P`]

]])
