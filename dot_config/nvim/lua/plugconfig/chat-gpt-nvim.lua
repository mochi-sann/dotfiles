require("chatgpt").setup({
	-- optional configuration
	keymaps = {
		close = { "<C-c>", "<Esc>" },
		yank_last = "<C-y>",
		scroll_up = "<C-u>",
		scroll_down = "<C-d>",
		toggle_settings = "<C-o>",
		new_session = "<C-n>",
		cycle_windows = "<Tab>",
		-- in the Sessions pane
		select_session = "<Space>",
		rename_session = "r",
		delete_session = "d",
	},
	answer_sign = "🤖", -- 🤖
	-- openai_params = {
	-- 	-- NOTE: model can be a function returning the model name
	-- 	-- this is useful if you want to change the model on the fly
	-- 	-- using commands
	-- 	-- Example:
	-- 	-- model = function()
	-- 	--     if some_condition() then
	-- 	--         return "gpt-4-1106-preview"
	-- 	--     else
	-- 	--         return "gpt-3.5-turbo"
	-- 	--     end
	-- 	-- end,
	-- 	model = "gpt-4-1106-preview",
	-- 	frequency_penalty = 0,
	-- 	presence_penalty = 0,
	-- 	max_tokens = 4095,
	-- 	temperature = 0.2,
	-- 	top_p = 0.1,
	-- 	n = 1,
	-- },
})

-- tk: talk to chatgpt
-- tj: talk to chatgpt as
-- tt: talk to chatgpt edit with instructions
vim.keymap.set("n", "<Space>tk", "<cmd>:ChatGPT<cr>")
vim.keymap.set("n", "<Space>tj", "<cmd>:ChatGPTActAs<cr>")
-- vim.keymap.set("n", "<Space>tt", "<cmd>:ChatGPTEditWithInstructions<cr>")
