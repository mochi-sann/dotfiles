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

	{
		"nathom/filetype.nvim",
		config = function()
			require("filetype").setup({
				overrides = {
					extensions = {
						-- Set the filetype of *.pn files to potion
						pn = "potion",
					},
					literal = {
						-- Set the filetype of files named "MyBackupFile" to lua
						MyBackupFile = "lua",
					},
					complex = {
						-- Set the filetype of any full filename matching the regex to gitconfig
						[".*git/config"] = "gitconfig", -- Included in the plugin
					},
					-- The same as the ones above except the keys map to functions
					function_extensions = {
						["cpp"] = function()
							vim.bo.filetype = "cpp"
							-- Remove annoying indent jumping
							vim.bo.cinoptions = vim.bo.cinoptions .. "L0"
						end,
						["pdf"] = function()
							vim.bo.filetype = "pdf"
							-- Open in PDF viewer (Skim.app) automatically
							vim.fn.jobstart("open -a skim " .. '"' .. vim.fn.expand("%") .. '"')
						end,
					},
					function_literal = {
						Brewfile = function()
							vim.cmd("syntax off")
						end,
					},
					function_complex = {
						["*.math_notes/%w+"] = function()
							vim.cmd("iabbrev $ $$")
						end,
					},
					shebang = {
						-- Set the filetype of files with a dash shebang to sh
						dash = "sh",
					},
				},
			})
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("plugconfig/nvim-scrollbar")
		end,
	},

	-- { "junegunn/fzf", build = ":call fzf#install()", event = "VeryLazy" },
	{ "nvim-lua/popup.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		module = { "telescope" },
		event = "VeryLazy",
		dependencies = {
			{ "nvim-telescope/telescope-ghq.nvim" },
			{ "nvim-telescope/telescope-z.nvim" },
			{
				"nvim-telescope/telescope-frecency.nvim",
			},

			-- その他の拡張プラグイン……
		},
		init = function() end,
		config = function()
			require("plugconfig/telescope")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-emoji" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-emoji" },
			{ "hrsh7th/cmp-nvim-lsp-document-symbol" },
			{
				"hrsh7th/cmp-vsnip",
				dependencies = { "vim-vsnip", "cmp-nvim-lsp-document-symbol" },
			},
			{
				"SmiteshP/nvim-navic",
				config = function()
					require("plugconfig/nvim_navic")
				end,
			},
			{
				"onsails/lspkind.nvim",
				config = function()
					require("plugconfig/lspkind")
				end,
			}, -- {
			-- 	"tzachar/cmp-tabnine",
			-- 	config = function()
			-- 		require("plugconfig/cmp-tabnine")
			-- 	end,
			-- 	build = "./install.sh",
			-- },
			{
				"j-hui/fidget.nvim",
				config = function()
					require("fidget").setup({})
				end,
			},
			{ "neovim/nvim-lspconfig" },
			{
				"williamboman/mason-lspconfig.nvim",
				config = function()
					require("plugconfig/mason-lsp")
				end,
			},
			{ "williamboman/mason.nvim" },
			{
				"hrsh7th/vim-vsnip",
				config = function()
					require("plugconfig/vsnip")
				end,
				dependencies = { { "hrsh7th/vim-vsnip-integ" } },
			},
			{
				"ray-x/lsp_signature.nvim",
				event = "VeryLazy",
				opts = {},
				config = function(_, opts)
					require("lsp_signature").setup()
				end,
			},

			-- {
			-- 	"zbirenbaum/copilot-cmp",
			-- 	config = function()
			-- 		require("copilot_cmp").setup()
			-- 	end,
			-- },
			-- {
			-- 	"zbirenbaum/copilot.lua",
			-- 	config = function()
			-- 		require("copilot").setup({})
			-- 	end,
			-- },
			{
				"lvimuser/lsp-inlayhints.nvim",
			},
			{ "simrat39/rust-tools.nvim" },
		},
		event = { "InsertEnter", "CmdwinEnter", "CmdlineEnter" },
		config = function()
			require("plugconfig/nvim_cmp")
		end,
	},
	{
		"LintaoAmons/bookmarks.nvim",
		-- tag = "v0.5.4", -- optional, pin the plugin at specific version for stability
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
			{ "stevearc/dressing.nvim" }, -- optional: to have the same UI shown in the GIF
		},
		event = "VeryLazy",
	},

	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
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
	{ "kyazdani42/nvim-web-devicons" },
	{
		"akinsho/bufferline.nvim",
		version = "v2.*",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			require("plugconfig/bufferline")
		end,
	},
	-- {
	-- 	"alvarosevilla95/luatab.nvim",buffer
	-- 	dependencies = "kyazdani42/nvim-web-devicons",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("plugconfig/luatab")
	-- 	end,
	-- }, --
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
		config = true,
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
		"heavenshell/vim-jsdoc",
		event = "VeryLazy",
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
		opts = {},
		config = function()
			require("plugconfig/indent_blankline")
		end,
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
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
			"justinhj/battery.nvim",
			"nvim-lua/plenary.nvim",
		},
		event = "VeryLazy",
		config = function()
			require("plugconfig/lualine")
		end,
	},
	{
		"echasnovski/mini.nvim",
		branch = "stable",
		event = "VeryLazy",
		config = function()
			require("plugconfig/mini")
		end,
	}, -- {
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
	{ "ryanoasis/vim-devicons" }, -- {
	-- 	"relastle/vim-colorrange",
	-- 	event = "VeryLazy",
	-- },

	{
		"uga-rosa/ccc.nvim",
		-- event = { "VeryLazy" },
		dependenciek = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("plugconfig/ccc-nvim")
		end,
		-- keys = { ":CccPick<cr>" },
	},
	{ "nvim-lua/plenary.nvim" },
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
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
		tag = "stable",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = { "rust", "toml" },
		config = function()
			require("crates").setup()
		end,
	},
	{ "slim-template/vim-slim", ft = { "slim" } },
	{ "wakatime/vim-wakatime", event = "VeryLazy" },
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

	-- {
	-- 	"nvim-neotest/neotest",
	-- 	dependencies = {
	-- 		"nvim-neotest/nvim-nio",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"antoinemadec/FixCursorHold.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 	},
	-- 	config = function()
	-- 		require("plugconfig/neotest")
	-- 	end,
	-- },
	-- {
	-- 	"mrcjkb/rustaceanvim",
	-- 	version = "^5", -- Recommended
	-- 	lazy = false, -- This plugin is already lazy
	-- },

	-- {
	-- 	"mochi-sann/Select2Browser.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("Select2Browser").setup()
	-- 		vim.api.nvim_set_keymap("", "<Leader>gg", "<Cmd>Select2Browser<CR>", { noremap = true, silent = true })
	-- 	end,
	-- },
	-- {
	-- 	"jackMort/ChatGPT.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("plugconfig/chat-gpt-nvim")
	-- 	end,
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"folke/trouble.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 	},
	-- },
	{
		"folke/zen-mode.nvim",
		event = "VeryLazy",
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
				log_level = "error",
				auto_save_enabled = true,
			})
			vim.api.nvim_set_keymap("", "<Leader>ss", "<Cmd>SessionSave<CR>", { noremap = true, silent = false })
			vim.api.nvim_set_keymap("", "<Leader>sd", "<Cmd>SessionDelete<CR>", { noremap = true, silent = false })
			vim.api.nvim_set_keymap("", "<Leader>sr", "<Cmd>SessionRestore<CR>", { noremap = true, silent = false })
		end,
	},
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = {
			{ "kyazdani42/nvim-web-devicons" }, -- optional, for file icons
		},
		config = function()
			require("plugconfig/nvim-tree")
		end,

		event = "VeryLazy",
	},
	{
		"stevearc/aerial.nvim",
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

			require("aerial").setup({
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '{' and '}'
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
			})
		end,
	},
	{
		"s1n7ax/nvim-window-picker",
		config = function()
			require("window-picker").setup({
				selection_chars = "ASDFGHJKL;QWERUIOP",
				show_prompt = false,
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
				vim.keymap.set({ "n", "t" }, "<C-w><C-" .. key .. ">", callback)
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
    lazy = true ,
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
	-- {
	-- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- 	opts = {
	-- 		show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
	-- 		debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
	-- 		disable_extra_info = "no", -- Disable extra information (e.g: system prompt) in the response.
	-- 		language = "English", -- Copilot answer language settings when using default prompts. Default language is English.
	-- 		-- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
	-- 	},
	-- 	build = function()
	-- 		vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
	-- 	end,
	-- 	keys = {
	-- 		{ "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
	-- 		{ "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
	-- 		{
	-- 			"<leader>ccT",
	-- 			"<cmd>CopilotChatVsplitToggle<cr>",
	-- 			desc = "CopilotChat - Toggle Vsplit", -- Toggle vertical split
	-- 		},
	-- 		{
	-- 			"<leader>ccv",
	-- 			":CopilotChatVisual",
	-- 			mode = "x",
	-- 			desc = "CopilotChat - Open in vertical split",
	-- 		},
	-- 		{
	-- 			"<leader>ccx",
	-- 			":CopilotChatInPlace<cr>",
	-- 			mode = "x",
	-- 			desc = "CopilotChat - Run in-place code",
	-- 		},
	-- 		{
	-- 			"<leader>ccf",
	-- 			"<cmd>CopilotChatFixDiagnostic<cr>", -- Get a fix for the diagnostic message under the cursor.
	-- 			desc = "CopilotChat - Fix diagnostic",
	-- 		},
	-- 		{
	-- 			"<leader>ccr",
	-- 			"<cmd>CopilotChatReset<cr>", -- Reset chat history and clear buffer.
	-- 			desc = "CopilotChat - Reset chat history and clear buffer",
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- 	branch = "canary",
	-- 	dependencies = {
	-- 		{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
	-- 		{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
	-- 	},
	-- 	opts = {
	-- 		debug = true, -- Enable debugging
	-- 		-- See Configuration section for rest
	-- 	},
	-- 	-- See Commands section for default commands if you want to lazy load on them
	-- },

	{
		"ruifm/gitlinker.nvim",
		event = "VeryLazy",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("gitlinker").setup()
		end,
	},
	{
		"nvim-pack/nvim-spectre",
		event = "VeryLazy",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("plugconfig/spectre")
		end,
	},
	{
		"cshuaimin/ssr.nvim",
		event = "VeryLazy",
		-- Calling setup is optional.
		config = function()
			require("ssr").setup({
				border = "rounded",
				min_width = 50,
				min_height = 5,
				max_width = 120,
				max_height = 25,
				adjust_window = true,
				keymaps = {
					close = "q",
					next_match = "n",
					prev_match = "N",
					replace_confirm = "<cr>",
					replace_all = "<leader><cr>",
				},
			})
			vim.keymap.set({ "n", "x" }, "<leader>st", function()
				require("ssr").open()
			end)

			vim.api.nvim_create_user_command("Ssr", function(ctx)
				require("ssr").open()
			end, {
				nargs = "*",
				desc = "Structural search and replace for Neovim.",
			})
		end,
	},
	{ "sindrets/diffview.nvim", event = "VeryLazy" },
	{ "jay-babu/mason-nvim-dap.nvim", dependencies = { "mfussenegger/nvim-dap", "williamboman/mason.nvim" } },
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
		opts = {
			auto_start = true,
			port = 24917,
		},
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = true,
		-- version = false, -- set this if you want to always pull the latest change

		opts = require("plugconfig/avante-nvim"),
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",

		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
		},
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
