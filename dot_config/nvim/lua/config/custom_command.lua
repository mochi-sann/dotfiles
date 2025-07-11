vim.api.nvim_create_user_command("CloseBuffers", function()
	local current_buf = vim.api.nvim_get_current_buf()
	local buffers_to_keep = {}
	local closed_count = 0

	-- 現在のバッファと変更のあるバッファをリストに追加
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_get_option(buf, "modified") or buf == current_buf then
			table.insert(buffers_to_keep, buf)
		end
	end

	-- 保持するバッファ以外を閉じる
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if not vim.tbl_contains(buffers_to_keep, buf) then
			if pcall(vim.api.nvim_buf_delete, buf, { force = false }) then
				closed_count = closed_count + 1
			end
		end
	end

	vim.notify(closed_count .. " buffers closed", vim.log.levels.INFO)
end, {})

-- bufを離れたときに保存する
vim.api.nvim_create_autocmd("BufLeave", {
	pattern = "*",
	callback = function()
		if vim.bo.modified and vim.bo.buftype == "" then
			vim.cmd("write")
		end
	end,
})
vim.api.nvim_create_user_command("ProfileStart", function()
	vim.cmd("profile start profile.log")
	vim.cmd("profile func *")
	vim.cmd("profile file *")
	print("Profiling started")
end, {})

vim.api.nvim_create_user_command("ProfileStop", function()
	vim.cmd("profile pause")
	vim.cmd("profile dump")
	print("Profiling stopped, check profile.log")
end, {})
