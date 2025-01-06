return {
	"nvim-telescope/telescope.nvim",
	module = { "telescope" },
	-- event = "VeryLazy",
	lazy = true,
	keys = {
		{ "n", "<Leader>pp" },
		{ "n", "<Leader>pgr" },
		{ "n", "<Leader>pd" },
		{ "n", "<Leader>ph" },
		{ "n", "<Leader>pb" },
		{ "n", "<Leader>pba" },
		{ "n", "<Leader>po" },
		{ "n", "<Leader>pk" },
		{ "n", "<Leader>pr" },
		{ "n", "<Leader>pc" },
		{ "n", "<Leader>pi" },
		{ "n", "<Leader>pg" },
		{ "n", "<Leader>pz" },
	},
	dependencies = {
		{ "nvim-telescope/telescope-ghq.nvim" },
		{ "nvim-telescope/telescope-z.nvim" },
		{
			"nvim-telescope/telescope-frecency.nvim",
		},
		{ "piersolenski/telescope-import.nvim" },

		-- その他の拡張プラグイン……
	},
	init = function() end,
	config = function()
		local telescope = require("telescope")
		telescope.load_extension("frecency")
		telescope.load_extension("import")
		local actions = require("telescope.actions")
		local vim = vim

		local function builtin(name)
			return function(opt)
				return function()
					return require("telescope.builtin")[name](opt or {})
				end
			end
		end

		local function extensions(name, prop)
			return function(opt)
				return function()
					local telescope = require("telescope")
					telescope.load_extension(name)
					return telescope.extensions[name][prop](opt or {})
				end
			end
		end

		vim.keymap.set(
			"n",
			"<Leader>pp",
			builtin("find_files")({
				hidden = false,
				-- file_ignore_patterns = { ".git/", "node_modules", ".next", "dist", "out" },
			})
		)
		vim.keymap.set("n", "<Leader>pgr", builtin("live_grep")({}), { desc = "telescope libe_grep" })
		vim.keymap.set("n", "<Leader>pd", builtin("diagnostics")({}), { desc = "telescope diagnostics" })
		vim.keymap.set("n", "<Leader>ph", builtin("help_tags")({}), { desc = "telescope help tags" })
		vim.keymap.set("n", "<Leader>pb", builtin("buffers")({}), { desc = "telescope buffers" })
		vim.keymap.set("n", "<Leader>pba", builtin("buffers")({}), { desc = "telescope buffers" })
		vim.keymap.set("n", "<Leader>po", builtin("command")({}), { desc = "telescope command" })
		vim.keymap.set("n", "<Leader>pk", builtin("keymap")({}), { desc = "telescope keymap" })
		vim.keymap.set("n", "<Leader>pc", builtin("command_history")({}), { desc = "telescope command_history" })
		vim.keymap.set("n", "<Leader>pr", builtin("resume")({}), { desc = "telescope resume" })
		vim.keymap.set("n", "<Leader>pi", extensions("import", "import")({}), { desc = "telescope import" })
		vim.keymap.set("n", "<Leader>pg", extensions("ghq", "list")({}), { desc = "telescope ghq list" })
		vim.keymap.set("n", "<Leader>pz", extensions("z", "list")({}), { desc = "telescope z list" })

		telescope.setup({
			defaults = {
				-- Default configuration for telescope goes here:
				-- config_key = value,
				borderchars = {
					{ "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
					results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
					preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				},

				winblend = 8,
				prompt_title = "",
				results_title = "",
				preview_title = "",
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						width = 0.8,
						prompt_position = "top",
						show_line = true,
						sorting_strategy = "ascending",
					},
					-- other layout configuration here
				},

				mappings = {
					i = {
						-- map actions.which_key to <C-h> (default: <C-/>)
						-- actions.which_key shows the mappings for your picker,
						-- e.g. git_{create, delete, ...}_branch for the git_branches picker
						["<C-h>"] = "which_key",
						["<C-j>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
						["<C-q>"] = actions.close,
					},
				},
			},
			pickers = {
				-- Default configuration for builtin pickers goes here:
				-- picker_name = {
				--   picker_config_key = value,
				--   ...
				-- }
				-- Now the picker_config_key will be applied every time you call this
				-- builtin picker
				layout_config = { prompt_position = "top" },
			},
			extensions = {
				-- Your extension configuration goes here:
				-- extension_name = {
				--   extension_config_key = value,
				-- }
				-- please take a look at the readme of the extension you want to configure
			},
			file_ignore_patterns = { "node_modules", ".git/" },
		})
		local full_theme = { width = 0.8, show_line = true }

		--telescope.load_extension("frecency")
		-- then use it on whatever picker you want
		-- ex:
		-- require("telescope.builtin").layout_strategies.cursor(full_theme)
	end,
}
