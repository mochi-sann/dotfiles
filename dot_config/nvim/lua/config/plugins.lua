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
	-- { "junegunn/fzf", build = ":call fzf#install()", event = "VimEnter" },
	{ "nvim-lua/popup.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		module = { "telescope" },
		event = "UIEnter",
		dependencies = {
			{ "nvim-telescope/telescope-ghq.nvim" },
			{ "nvim-telescope/telescope-z.nvim" },
			{
				"nvim-telescope/telescope-frecency.nvim",
				dependencies = { "kkharji/sqlite.lua" },
			},
			"telescope-ghq.nvim",
			"telescope-z.nvim",
			"telescope-frecency.nvim",

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
			{ "SmiteshP/nvim-navic" },
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
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup()
				end,
			},
			{
				"zbirenbaum/copilot.lua",
				config = function()
					require("copilot").setup({})
				end,
			},
		},
		event = { "UIEnter" },
		config = function()
			require("plugconfig/nvim_cmp")
		end,
	},
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		event = "VimEnter",
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
		event = "VimEnter",
		config = function()
			require("plugconfig/vim_quichl")
		end,
	},
	{
		"terryma/vim-expand-region",
		event = "VimEnter",
		config = function()
			require("plugconfig/vim_expand_region")
		end,
	},
	{ "segeljakt/vim-silicon", event = "VimEnter" }, -- colorschem

	{
		"folke/tokyonight.nvim",
		config = function()
			require("plugconfig/tokyonight_nvim")
		end,
	},
	{ "catppuccin/nvim", name = "catppuccin", lazy = true },

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
			require("bufferline").setup({})
		end,
	},
	{
		"alvarosevilla95/luatab.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		event = "VimEnter",
		config = function()
			require("plugconfig/luatab")
		end,
	}, --
	-- {
	--   "vim-jp/vimdoc-ja",
	--   event = "VimEnter",
	--   config = function()
	--     require("plugconfig/vimdoc_ja")
	--   end,
	-- },
	-- terminal
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "VimEnter",
		config = function()
			require("plugconfig/toggleterm")
		end,
	},
	{
		"willothy/flatten.nvim",
		config = true,
		-- or pass configuration with
		-- opts = {  }
		-- Ensure that it runs first to minimize delay when opening file from terminal
		lazy = false,
		priority = 1001,
	},

	{
		"chomosuke/term-edit.nvim",
		version = "1.*",
		event = "UIEnter",
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
		event = "UIEnter",
		-- or pass configuration with
		-- opts = {  }
		-- Ensure that it runs first to minimize delay when opening file from terminal
	}, -- git
	{
		"kdheepak/lazygit.nvim",
		event = "VimEnter",
		config = function()
			require("plugconfig/lazygit")
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		event = "VimEnter",
		version = "*",
		config = function()
			require("git-conflict").setup()
		end,
	},
	{ "alaviss/nim.nvim", event = "VimEnter" },
	{
		"heavenshell/vim-jsdoc",
		event = "VimEnter",
		cmd = { "JsDoc" },
		ft = {
			"typescript",
			"typescriptreact",
			"javascript",
			"javascriptreact",
			"vue",
		},
	}, -- {
	--   "steelsojka/pears.nvim",
	--   event = "VimEnter",
	--   config = function()
	--     require("plugconfig/pears")
	--   end,
	-- },
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VimEnter",
		config = function()
			require("plugconfig/indent_blankline")
		end,
	},
	--  treesitter settins
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
			{ "windwp/nvim-ts-autotag" },
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
		},
		config = function()
			require("plugconfig/treesitter")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VimEnter",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{ "MunifTanjim/nui.nvim", event = "VimEnter" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
			"justinhj/battery.nvim",
			"nvim-lua/plenary.nvim",
		},
		event = "VimEnter",
		config = function()
			require("plugconfig/lualine")
		end,
	},
	{
		"echasnovski/mini.nvim",
		branch = "stable",
		event = "VimEnter",
		config = function()
			require("plugconfig/mini")
		end,
	}, -- {
	-- 	"tversteeg/registers.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("registers").setup()
	-- 	end,
	-- },
	{
		"tversteeg/registers.nvim",
		event = "VimEnter",
		config = function()
			require("registers").setup()
		end,
	}, -- {
	-- 	"folke/which-key.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("plugconfig/whichi_key")
	-- 	end,
	-- },
	{ "ryanoasis/vim-devicons" }, -- {
	-- 	"relastle/vim-colorrange",
	-- 	event = "VimEnter",
	-- },
	{
		"uga-rosa/ccc.nvim",
		event = { "VimEnter" },
		dependenciek = { "nvim-telescope/telescope.nvim" },
		-- keys = { ":CccPick<cr>" },
		config = function()
			require("plugconfig/ccc-nvim")
		end,
	},
	{ "nvim-lua/plenary.nvim" },
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		event = "VimEnter",
		config = function()
			require("plugconfig/todo-comments")
		end,
	},
	{
		"ibhagwan/smartyank.nvim",
		event = "VimEnter",
		config = function()
			require("plugconfig/smartyank")
		end,
	},
	{ "t9md/vim-choosewin", event = "VimEnter" }, -- {
	-- 	"jose-elias-alvarez/null-ls.nvim",
	-- 	onfig = function()
	-- 		require("plugconfig/null_ls")
	-- 	end,
	-- },
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "VimEnter",
		dependencies = { "jayp0521/mason-null-ls.nvim", "williamboman/mason.nvim" },
		onfig = function()
			require("plugconfig/null_ls")
		end,
	},
	-- { "davidgranstrom/nvim-markdown-preview", opt = true, event = "VimEnter" },
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{ "rust-lang/rust.vim", ft = { "rust", "toml" } }, -- {
	{
		"saecki/crates.nvim",
		tag = "v0.3.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugconfig/null_ls")
		end,
	},
	{ "slim-template/vim-slim", ft = { "slim" } },
	-- 	"SmiteshP/nvim-navic",
	-- 	config = function()
	-- 		require("plugconfig/nvim_navic")
	-- 	end,
	--
	-- 	requires = "neovim/nvim-lspconfig",
	-- },
	{ "wakatime/vim-wakatime", event = "VimEnter" },
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
		event = "VimEnter",
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
		"mochi-sann/Select2Browser.nvim",
		event = "VimEnter",
		config = function()
			require("Select2Browser").setup()
			vim.api.nvim_set_keymap("", "<Leader>gg", "<Cmd>Select2Browser<CR>", { noremap = true, silent = true })
		end,
	},
	-- {
	-- 	"jackMort/ChatGPT.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("plugconfig/chat-gpt-nvim")
	-- 	end,
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 	},
	-- },
	{
		"folke/zen-mode.nvim",
		event = "VimEnter",
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
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
				auto_save_enabled = false,
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
		event = "VimEnter",
		config = function()
			require("plugconfig/nvim-tree")
		end,
	},
	{
		"stevearc/aerial.nvim",
		event = "VimEnter",
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
	{ "mfussenegger/nvim-dap", event = "UIEnter" },
	{ "tikhomirov/vim-glsl" },
	{
		"glacambre/firenvim",

		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		cond = not not vim.g.started_by_firenvim,
		build = function()
			require("lazy").load({ plugins = "firenvim", wait = true })
			vim.fn["firenvim#install"](0)
			vim.api.nvim_create_autocmd({ "BufEnter" }, {
				pattern = "github.com_*.txt",
				cmd = "set filetype=markdown",
			})

			if vim.g.started_by_firenvim == true then
				vim.o.laststatus = 0
			end
			vim.g.firenvim_config = {
				localSettings = {
					[".*"] = {
						priority = 0,
						selector = "",
					},
					["github.com"] = {
						priority = 1,
						selector = "textarea",
					},
				},
			}
		end,
	},
	{
		"winston0410/range-highlight.nvim",
		dependencies = { "winston0410/cmd-parser.nvim" },
		config = function()
			require("range-highlight").setup({})
		end,
	},

	-- file tree
})
