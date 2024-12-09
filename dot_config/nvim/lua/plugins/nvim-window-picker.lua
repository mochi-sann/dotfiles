return {
	"s1n7ax/nvim-window-picker",
  name = 'window-picker',
	version = "2.*",
	config = function()
		require("window-picker").setup({
			filter_rules = {
				include_current_win = false,
				autoselect_one = true,
				-- filter using buffer options
				bo = {
					-- if the file type is one of following, the window will be ignored
					filetype = { "neo-tree", "neo-tree-popup", "notify", "nvim-tree", "neo-tree-preview" },
					-- if the buffer type is one of following, the window will be ignored
					buftype = { "terminal", "quickfix", "neo-tree-preview" },
				},
			},
			hint = "floating-big-letter",
			-- selection_chars = "ASDFGHJKL;QWERUIOP",
			selection_chars = "FJDKSLA;CMRUEIWOQP",
			show_prompt = true,
			include_current_win = true,
			-- if you have include_current_win == true, then current_win_hl_color will
			-- be highlighted using this background color
			current_win_hl_color = "#e35e4f",
			use_winbar = "smart", -- "always" | "never" | "smart"

			-- all the windows except the curren window will be highlighted using this
			-- color
			other_win_hl_color = "#1a1b26",
		})
		local window_picker = require("window-picker")

		-- <C-w>xと<C-w><C-x>を同時に設定する
		local win_keymap_set = function(key, callback)
			vim.keymap.set({ "n", "t" }, "<C-w>" .. key, callback)
			vim.keymap.set({ "n", "t" }, "<C-w><C-" .. key .. ">", callback, {
				desc = "Switch to window using window-picker",
			})
		end

		win_keymap_set("w", function()
			local wins = 0

			-- 全ウィンドウをループ
			for i = 1, vim.fn.winnr("$") do
				local win_id = vim.fn.win_getid(i)
				local conf = vim.api.nvim_win_get_config(win_id)

				-- focusableなウィンドウをカウント
				if conf.focusable then
					wins = wins + 1

					-- ウィンドウ数が3以上ならchowchoを起動
					if wins > 2 then
						local picked_window_id = window_picker.pick_window() or vim.api.nvim_get_current_win()
						vim.api.nvim_set_current_win(picked_window_id)

						return
					end
				end
			end

			-- ウィンドウが少なければ標準の<C-w><C-w>を実行
			vim.api.nvim_command("wincmd w")
		end)
	end,
}
