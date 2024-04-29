require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"lua",
		"astro",
		"bash",
		"cmake",
		"dockerfile",
		"go",
		"html",
		"javascript",
		"json",
		"json5",
		"latex",
		"markdown",
		"php",
		"prisma",
		"python",
		"ruby",
		"rust",
		"svelte",
		"tsx",
		"typescript",
		"vim",
		"vue",
		"yaml",
		"cpp",
	},
	sync_install = true,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	highlight = {
		enable = true,
		-- disable = function(lang, buf)
		-- 	local max_filesize = 100 * 1024 -- 100 KB
		-- 	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
		-- 	if ok and stats and stats.size > max_filesize then
		-- 		return true
		-- 	end
		-- end,
	},

	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = 300, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
	autotag = { enable = true },
})
require("ts_context_commentstring").setup({
	enable_autocmd = false,
})
