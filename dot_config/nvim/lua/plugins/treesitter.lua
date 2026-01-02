return {

	--  treesitter settins
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("plugconfig/autotag")
		end,
		-- event = { "InsertEnter", "CmdwinEnter", "CmdlineEnter" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",

		event = "VeryLazy",
		dependencies = {
			-- { "mrjones2014/nvim-ts-rainbow" },
			{
				"nvim-treesitter/nvim-treesitter-context",
				config = function()
					require("treesitter-context").setup({
						enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
						multiwindow = true, -- Enable multiwindow support.
						max_lines = 5000, -- How many lines the window should span. Values <= 0 mean no limit.
						min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
						line_numbers = true,
						multiline_threshold = 20, -- Maximum number of lines to show for a single context
						trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
						mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
						-- Separator between context and content. Should be a single character string, like '-'.
						-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
						separator = nil,
						zindex = 20, -- The Z-index of the context window
						on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
					})
				end,
			},
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
		},
		config = function()
			require("nvim-treesitter").setup({
				ensure_installed = {
					"bash",
					"dockerfile",
					"javascript",
					"json",
					"markdown",
					"ruby",
					"tsx",
					"typescript",
					"vim",
					"yaml",
				},
				install_dir = vim.fn.stdpath("data") .. "/site",
				sync_install = true,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				highlight = {
					enable = true,
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				--
				rainbow = {
					enable = true,
					-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
					extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
					max_file_lines = 300, -- Do not enable for files with more than n lines, int
					-- colors = {}, -- table of hex strings
					-- termcolors = {} -- table of colour name strings
				},
				autotag = { enable = true },
				textsubjects = {
					enable = true,
					prev_selection = ",", -- (Optional) keymap to select the previous selection
					keymaps = {
						["."] = "textsubjects-smart",
						[";"] = "textsubjects-container-outer",
						["i;"] = "textsubjects-container-inner",
						["i;"] = { "textsubjects-container-inner", desc = "Select inside containers (classes, functions, etc.)" },
					},
				},
			})
			-- require("ts_context_commentstring").setup({
			-- 	enable_autocmd = false,
			-- })
		end,
	},
}
