return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	dependencies = {
		{ "nvim-telescope/telescope-ghq.nvim" },
		{ "nvim-telescope/telescope-z.nvim" },
		{
			"nvim-telescope/telescope-frecency.nvim",
		},
		{ "piersolenski/import.nvim" },
		{ "nvim-lua/plenary.nvim" },
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			-- This will not install any breaking changes.
			-- For major updates, this must be adjusted manually.
			version = "^1.0.0",
		},

		-- その他の拡張プラグイン……
	},
	-- tag = "0.1.8",
	init = function() end,
	config = function()
		local telescope = require("telescope")
		telescope.load_extension("frecency")
		telescope.load_extension("import")
		telescope.load_extension("live_grep_args")
		-- telescope.load_extension("nested_keys")
		local actions = require("telescope.actions")
		local vim = vim
		local function filename_sorter()
			local sorter = require("telescope.config").values.generic_sorter()
			local score = sorter.scoring_function
			sorter.scoring_function = function(self, prompt, _, entry)
				return score(self, prompt, entry.filename, entry)
			end
			return sorter
		end
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
		vim.keymap.set(
			"n",
			"<Leader>pgr",
			builtin("live_grep")({
				attach_mappings = function(prompt_bufnr, map)
					map("i", "<C-G><C-G>", function()
						require("telescope.actions").send_to_qflist(prompt_bufnr)
						require("telescope.builtin").quickfix({
							sorter = filename_sorter(),
						})
					end)
					return true
				end,
			}),
			{ desc = "telescope live_grep" }
		)
		vim.keymap.set("n", "<Leader>pd", builtin("diagnostics")({}), { desc = "telescope diagnostics" })
		vim.keymap.set("n", "<Leader>ph", builtin("help_tags")({}), { desc = "telescope help tags" })
		vim.keymap.set("n", "<Leader>pb", builtin("buffers")({}), { desc = "telescope buffers" })
		vim.keymap.set("n", "<Leader>pba", builtin("buffers")({}), { desc = "telescope buffers" })
		vim.keymap.set("n", "<Leader>po", builtin("command")({}), { desc = "telescope command" })
		vim.keymap.set("n", "<Leader>pk", builtin("keymap")({}), { desc = "telescope keymap" })
		vim.keymap.set("n", "<Leader>pch", builtin("command_history")({}), { desc = "telescope command_history" })
		vim.keymap.set("n", "<Leader>pr", builtin("resume")({}), { desc = "telescope resume" })
		vim.keymap.set("n", "<Leader>pl", builtin("lsp_definitions")({}), { desc = "telescope lsp_definitions" })
		vim.keymap.set(
			"n",
			"<Leader>pcf",
			builtin("current_buffer_fuzzy_find")({}),
			{ desc = "telescope current_buffer_fuzzy_find" }
		)
		vim.keymap.set("n", "<Leader>pi", extensions("import", "import")({}), { desc = "telescope import" })
		vim.keymap.set("n", "<Leader>pg", extensions("ghq", "list")({}), { desc = "telescope ghq list" })
		vim.keymap.set("n", "<Leader>pz", extensions("z", "list")({}), { desc = "telescope z list" })
		vim.keymap.set(
			"n",
			"<Leader>pK",
			extensions("nested_keys", "nested_keys")({}),
			{ desc = "telescope JSON/YAML keys" }
		)

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

				winblend = 0,
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
