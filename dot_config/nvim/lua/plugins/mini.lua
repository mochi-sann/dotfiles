return {
	"echasnovski/mini.nvim",
	branch = "stable",
	event = "VeryLazy",
	lazy = true,
	config = function()
		require("mini.pairs").setup({
			-- In which modes mappings from this `config` should be created
			-- modes = { insert = true, command = false, terminal = false },

			-- Global mappings. Each right hand side should be a pair information, a
			-- table with at least these fields (see more in |MiniPairs.map|):
			-- - <action> - one of 'open', 'close', 'closeopen'.
			-- - <pair> - two character string for pair to be used.
			-- By default pair is not inserted after `\`, quotes are not recognized by
			-- `<CR>`, `'` does not insert pair after a letter.
			-- Only parts of tables can be tweaked (others will use these defaults).
			mappings = {
				["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
				["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
				["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

				[")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
				["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
				["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

				['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
				["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
				["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
			},
		})
		-- require('mini.sessions').setup({
		--
		-- })
		require("mini.surround").setup({

			-- Number of lines within which surrounding is searched
			n_lines = 20,

			-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
			highlight_duration = 500,

			-- Pattern to match function name in 'function call' surrounding
			-- By default it is a string of letters, '_' or '.'
			-- funname_pattern = "[%w_%.]+",

			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				add = "sa", -- Add surrounding
				delete = "sd", -- Delete surrounding
				find = "sf", -- Find surrounding (to the right)
				find_left = "sF", -- Find surrounding (to the left)
				highlight = "sh", -- Highlight surrounding
				replace = "sr", -- Replace surrounding
				update_n_lines = "sn", -- Update `n_lines`
			},
		})
		require("mini.comment").setup({
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
				end,
			},

			mappings = {
				-- Toggle comment (like `gcip` - comment inner paragraph) for both
				-- Normal and Visual modes
				comment = "gc",

				-- Toggle comment on current line
				comment_line = "gcc",

				-- Define 'comment' textobject (like `dgc` - delete whole comment block)
				textobject = "gc",
			},
		})

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				require("mini.cursorword").setup({
					-- Delay (in ms) between when cursor moved and when highlighting appeared
					delay = 100,
				})
			end,
		})
		require("mini.trailspace").setup({
			-- Highlight only in normal buffers (ones with empty 'buftype'). This is
			-- useful to not show trailing whitespace where it usually doesn't matter.
			only_in_normal_buffers = true,
		})
	end,
}
