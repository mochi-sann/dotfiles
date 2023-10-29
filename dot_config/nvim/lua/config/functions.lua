vim.opt.clipboard = "unnamedplus"
if vim.fn.has("wsl") then
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = "/mnt/c/Users/mochi/scoop/shims/win32yank.exe -i --crlf",
			["*"] = "/mnt/c/Users/mochi/scoop/shims/win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "/mnt/c/Users/mochi/scoop/shims/win32yank.exe -o --crlf",
			["*"] = "/mnt/c/Users/mochi/scoop/shims/win32yank.exe -o --crlf",
		},
		cache_enable = 0,
	}
end
