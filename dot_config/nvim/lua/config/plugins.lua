local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local vim = vim
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({ -- Packer can manage itself

	{ import = "plugins" },
	{ "nvim-lua/plenary.nvim", lazy = true },
	{
		"lambdalisue/vim-suda",
		lazy = true,
		cmd = {
			"SudaWrite",
			"SudaRead",
		},
	},
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("plugconfig/nvim-scrollbar")
		end,
	},

	-- { "junegunn/fzf", build = ":call fzf#install()", event = "VeryLazy" },
	{ "nvim-lua/popup.nvim", lazy = true },
	{
		"LintaoAmons/bookmarks.nvim",
		-- recommand, pin the plugin at specific version for stability
		-- backup your db.json file when you want to upgrade the plugin
		-- tag = "v2.0.0",
		dependencies = {
			{ "kkharji/sqlite.lua" },
			{ "nvim-telescope/telescope.nvim" },
			{ "stevearc/dressing.nvim" }, -- optional: better UI
		},
		config = function()
			local opts = {} -- go to the following section to see all the options
			require("bookmarks").setup(opts) -- you must call setup to init sqlite db
		end,
		event = "VeryLazy",
	},

	{
		"smoka7/hop.nvim",
		event = "VeryLazy",
		config = function()
			require("plugconfig/hop")
		end,
	},
	--{
	--	"folke/flash.nvim",
	--	event = "VeryLazy",
	--	---@type Flash.Config
	--	opts = {},
	---- stylua: ignore
	--keys = {
	--  { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
	--  { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
	--  { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
	--  { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
	--  { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	--},
	--},
	{
		"t9md/vim-quickhl",
		event = "VeryLazy",
		config = function()
			require("plugconfig/vim_quichl")
		end,
	},
	{
		"terryma/vim-expand-region",
		event = "VeryLazy",
		config = function()
			require("plugconfig/vim_expand_region")
		end,
	},
	{ "segeljakt/vim-silicon", event = "VeryLazy" }, -- colorschem

	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			require("plugconfig/tokyonight_nvim")
		end,
	},
	-- { "catppuccin/nvim", name = "catppuccin", lazy = true },
	-- { "shaunsingh/nord.nvim", config = {  } },

	---------------------------------------------------------------------------
	-- { "NLKNguyen/papercolor-theme", as = "papercolor" },
	-- {
	-- 	"f-person/auto-dark-mode.nvim",
	-- 	config = function()
	-- 		require("plugconfig/auto-dark-mode")
	-- 	end,
	-- },
	-- { "sainnhe/sonokai" },

	--	{
	--		"rmagatti/auto-session",
	--		config = function()
	--			require("auto-session").setup({
	--				log_level = "error",
	--				auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
	--			}),
	--		end,
	--	},

	-- "rebelot/kanagawa.nvim")
	{ "kyazdani42/nvim-web-devicons", lazy = true },

	{
		"alvarosevilla95/luatab.nvim",
		event = "VeryLazy",
		config = function()
			require("luatab").setup({})
		end,
	}, --
	-- {
	--   "vim-jp/vimdoc-ja",
	--   event = "VeryLazy",
	--   config = function()
	--     require("plugconfig/vimdoc_ja")
	--   end,
	-- },
	-- terminal
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("plugconfig/toggleterm")
		end,
	},
	{
		"chomosuke/term-edit.nvim",
		ft = "toggleterm",
		version = "1.*",
		config = function()
			require("term-edit").setup({
				prompt_end = " %❯ ",
			})
		end,
		-- Enter insert as if this plugin doesn't exist: <C-i>
		-- Enter insert: i, a, A, I.
		-- Delete: d<motion>, dd, D, x.
		-- Change: c<motion>, cc, C, s, S.
		-- Visual change: c in visual mode.
		-- Visual delete: d, x in visual mode.
		-- Paste: p P "<register>p "<register>P
		-- Replace: r in normal mode
	},
	{
		"willothy/flatten.nvim",
		-- or pass configuration with
		-- opts = {  }
		-- Ensure that it runs first to minimize delay when opening file from terminal
		lazy = false,
		priority = 1001,
		config = function()
			require("flatten").setup({})
		end,
	},

	{
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
		keys = { "<Space>lg" },
		config = function()
			require("plugconfig/lazygit")
		end,
	},
	{ "rhysd/git-messenger.vim" },
	{
		"akinsho/git-conflict.nvim",
		event = "VeryLazy",
		version = "*",
		config = function()
			require("git-conflict").setup()
		end,
	},
	{ "alaviss/nim.nvim", event = "VeryLazy" },
	{
		"axelvc/template-string.nvim",
		config = function()
			require("template-string").setup({
				filetypes = {
					"html",
					"typescript",
					"javascript",
					"typescriptreact",
					"javascriptreact",
					"vue",
					"svelte",
					"python",
					"astro",
				}, -- filetypes where the plugin is active
				jsx_brackets = true, -- must add brackets to JSX attributes
				remove_template_string = false, -- remove backticks when there are no template strings
				restore_quotes = {
					-- quotes used when "remove_template_string" option is enabled
					normal = [[']],
					jsx = [["]],
				},
			})
		end,
		ft = {
			"html",
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
			"vue",
			"svelte",
			"python",
			"astro",
		},
	},
	{
		"heavenshell/vim-jsdoc",
		cmd = { "JsDoc" },
		ft = {
			"typescript",
			"typescriptreact",
			"javascript",
			"javascriptreact",
			"vue",
			"svelte",
		},
	}, -- {
	--   "steelsojka/pears.nvim",
	--   event = "VeryLazy",
	--   config = function()
	--     require("plugconfig/pears")
	--   end,
	-- },
	{
		"https://codeberg.org/esensar/nvim-dev-container",
		lazy = true,
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = {
			-- NOTE: The Subs command name can be customized via the option "substitude_command_name"
			"DevcontainerStart",
			"DevcontainerAttach",
			"DevcontainerExec",
			"DevcontainerStop",
			"DevcontainerStopAll",
			"DevcontainerRemoveAll",
			"DevcontainerLogs",
			"DevcontainerEditNearestConfig",
		},

		config = function()
			require("devcontainer").setup({})
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			-- char
		},
		config = function()
			require("plugconfig/indent_blankline")
		end,
		event = "VeryLazy",
	},
	--  treesitter settins
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("plugconfig/autotag")
		end,
		event = { "InsertEnter", "CmdwinEnter", "CmdlineEnter" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			-- { "mrjones2014/nvim-ts-rainbow" },
			{
				"nvim-treesitter/nvim-treesitter-context",
				config = function()
					require("plugconfig/treesitter-context")
				end,
			},
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
			{ "RRethy/nvim-treesitter-textsubjects" },
		},
		config = function()
			require("plugconfig/treesitter")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{ "MunifTanjim/nui.nvim", event = "VeryLazy" },

	-- 	"tversteeg/registers.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("registers").setup()
	-- 	end,
	-- },
	{
		"tversteeg/registers.nvim",
		event = "VeryLazy",
		config = function()
			require("registers").setup()
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function()
			require("plugconfig/whichi_key")
		end,
	},
	{ "ryanoasis/vim-devicons", lazy = true }, -- {
	-- 	"relastle/vim-colorrange",
	-- 	event = "VeryLazy",
	-- },

	{
		"uga-rosa/ccc.nvim",
		event = { "VeryLazy" },
		-- dependenciek = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("plugconfig/ccc-nvim")
		end,
		-- keys = { ":CccPick<cr>" },
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		config = function()
			require("plugconfig/todo-comments")
		end,
	},
	{
		"ibhagwan/smartyank.nvim",
		event = "VeryLazy",
		config = function()
			require("plugconfig/smartyank")
		end,
	},
	{ "t9md/vim-choosewin", event = "VeryLazy" }, -- {
	-- 	"jose-elias-alvarez/null-ls.nvim",
	-- 	onfig = function()
	-- 		require("plugconfig/null_ls")
	-- 	end,
	-- },
	{
		"nvimtools/none-ls.nvim",
		event = "VeryLazy",
		dependencies = {
			"jayp0521/mason-null-ls.nvim",
			"williamboman/mason.nvim",
			"nvimtools/none-ls-extras.nvim",
			"gbprod/none-ls-php.nvim",
			"gbprod/none-ls-shellcheck.nvim",
			"saecki/crates.nvim",
			"jay-babu/mason-null-ls.nvim",
		},
		config = function()
			require("plugconfig/null_ls")
		end,
	},
	-- { "davidgranstrom/nvim-markdown-preview", opt = true, event = "VeryLazy" },
	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	-- 	ft = { "markdown" },
	-- 	build = function()
	-- 		vim.fn["mkdp#util#install"]()
	-- 	end,
	-- 	config = function()
	-- 		vim.cmd([[
	--        function OpenMarkdownPreview (url)
	--          execute " ! explorer.exe  " . a:url
	--        endfunction
	--        let g:mkdp_browserfunc = 'OpenMarkdownPreview'
	--      ]])
	-- 	end,
	-- },
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			vim.cmd([[
		    function OpenMarkdownPreview (url)
		      execute " ! explorer.exe  " . a:url
		    endfunction
		    let g:mkdp_browserfunc = 'OpenMarkdownPreview'
      ]])
		end,
	},

	{
		"saecki/crates.nvim",
		ft = { "rust", "toml" },
		config = function()
			require("crates").setup()
		end,
	},
	{ "slim-template/vim-slim", ft = { "slim" } },
	{
		"andweeb/presence.nvim",
		event = "InsertEnter",
		config = function()
			require("presence"):setup({ auto_update = false })
		end,
	},
	{
		"folke/noice.nvim",
		config = function()
			require("plugconfig/noice")
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				config = function()
					require("plugconfig/nvim-notify")
				end,
			},
		},
	},
	{
		"almo7aya/openingh.nvim",
	},

	{
		"folke/zen-mode.nvim",
		-- event = "VeryLazy",
		lazy = true,
		keys = {
			{ "<leader>z", "<cmd>ZenMode<CR>", desc = "Zen Mode" },
		},
		config = function()
			require("zen-mode").setup({
				window = {
					width = 150,
				},
				plugins = {
					kitty = {
						enabled = false,
						font = "+4", -- font size increment
					},
					-- this will change the font size on alacritty when in zen mode
					-- requires  Alacritty Version 0.10.0 or higher
					-- uses `alacritty msg` subcommand to change font size
					alacritty = {
						enabled = false,
						font = "14", -- font size
					},
					-- this will change the font size on wezterm when in zen mode
					-- See alse also the Plugins/Wezterm section in this projects README
					wezterm = {
						enabled = true,
						font = "+0", -- (10% increase per step)
					},
				},
			})
			vim.api.nvim_set_keymap("", "<Leader>z", "<Cmd>ZenMode<CR>", { noremap = true, silent = true })
		end,
	},
	{
		"tpope/vim-dadbod",
		event = "UIEnter",
		config = function()
			require("plugconfig/vim-dadbod")
		end,
		dependencies = { "kristijanhusak/vim-dadbod-ui" },
	},
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
				log_level = "error",
				auto_save_enabled = true,
				session_lens = {
					load_on_setup = false, -- Initialize on startup (requires Telescope)
					previewer = false, -- File preview for session picker
				},
			})
			vim.api.nvim_set_keymap("", "<Leader>ss", "<Cmd>SessionSave<CR>", { noremap = true, silent = false })
			vim.api.nvim_set_keymap("", "<Leader>sd", "<Cmd>SessionDelete<CR>", { noremap = true, silent = false })
			vim.api.nvim_set_keymap("", "<Leader>sr", "<Cmd>SessionRestore<CR>", { noremap = true, silent = false })
		end,
	},
	{
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("plugconfig/nvim-tree")
		end,

		event = "VeryLazy",
	},

	{ "tikhomirov/vim-glsl", event = "VeryLazy" },
	{ "koron/vim-budoux", event = "VeryLazy" },
	{ "monaqa/dial.nvim", event = "VeryLazy" },

	{
		"johmsalas/text-case.nvim",
		-- dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("textcase").setup({})
			require("telescope").load_extension("textcase")
		end,
		keys = {
			"ga", -- Default invocation prefix
			{ "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
		},
		lazy = true,
		cmd = {
			-- NOTE: The Subs command name can be customized via the option "substitude_command_name"
			"Subs",
			"TextCaseOpenTelescope",
			"TextCaseOpenTelescopeQuickChange",
			"TextCaseOpenTelescopeLSPChange",
			"TextCaseStartReplacingCommand",
		},
		-- If you want to use the interactive feature of the `Subs` command right away, text-case.nvim
		-- has to be loaded on startup. Otherwise, the interactive feature of the `Subs` will only be
		-- available after the first executing of it or after a keymap of text-case.nvim has been used.
	},

	{
		"winston0410/range-highlight.nvim",
		event = "VeryLazy",
		dependencies = { "winston0410/cmd-parser.nvim" },
		config = function()
			require("range-highlight").setup({})
		end,
	},

	{
		"zbirenbaum/copilot.lua",
		lazy = true,
		cmd = "Copilot",
		event = {
			"InsertEnter",
			"CmdwinEnter",
			"CmdlineEnter",
		},
		config = function()
			require("copilot").setup({
				copilot_model = "gpt-4o-copilot",
			})
		end,
	}, -- or github/copilot.vim
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = { -- Example mapping to toggle outline
			{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {
			-- Your setup opts here
		},
	},
	{
		"linrongbin16/gitlinker.nvim",
		cmd = "GitLink",
		opts = {},
		keys = {
			{ "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
			{ "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
		},
	},
	{
		-- 色々なファイルを見て置換するやつ
		"MagicDuck/grug-far.nvim",
		cmd = {
			"GrugFar",
			"GrugFarWithin",
			"GrugFarReplace",
			"GrugFarReplaceAll",
			"GrugFarReplaceAllInFile",
			"GrugFarReplaceInFile",
		},
		lazy = true,
		config = function()
			require("grug-far").setup({

				-- options, see Configuration section below
				-- there are no required options atm
				-- engine = 'ripgrep' is default, but 'astgrep' can be specified
			})
		end,
	},
	{ "sindrets/diffview.nvim", event = "VeryLazy" },
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { "mfussenegger/nvim-dap", "williamboman/mason.nvim" },
		lazy = true,
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("plugconfig/nvim-dap")
		end,
	},
	{
		"nabekou29/open-by-http.nvim",
		cmd = { "OpenByHttpServerStart", "OpenByHttpServerStop" },
		event = { "FocusLost" },
		lazy = true,
		opts = {
			auto_start = true,
			port = 24917,
		},
	},
	{
		"kchmck/vim-coffee-script",
	},
	{
		-- Make sure to set this up properly if you have lazy=true
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {
			file_types = { "markdown", "Avante" },
		},
		ft = { "markdown", "Avante" },
		keys = {
			-- suggested keymap
			{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
		},
	},
})
