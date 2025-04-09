return {
	"yetone/avante.nvim",
	-- event = "VeryLazy",
	lazy = true,
	version = false, -- 最新の変更を常に取得する場合はこれを設定
	cmd = {
		"AvanteDebug",
		"AvanteToggle",
		"AvanteFocus",
		"AvanteRefresh",
		"AvanteAsk",
		"AvanteEdit",
	},
	keys = {
		{ "<leader>aa", "<cmd>AvanteAsk<cr>", desc = "Ask" },
		{ "<leader>ae", "<cmd>AvanteEdit<cr>", desc = "Edit" },
		{ "<leader>ar", "<cmd>AvanteRefresh<cr>", desc = "Refresh" },
		{ "<leader>af", "<cmd>AvanteFocus<cr>", desc = "Focus" },
		{ "<leader>at", "<cmd>AvanteToggle<cr>", desc = "Toggle" },
	},

	opts = function()
		return {
			debug = false,
			---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
			provider = "openai", -- Claudeの使用を推奨

			-- auto_suggestions_provider = require("avante-status").get_suggestions_provider({
			-- 	"azure",
			-- 	"copilot",
			-- 	"claude",
			-- 	"openai",
			-- }),
			-- provider = "deepseek", -- Claudeの使用を推奨
			-- auto_suggestions_provider = "copilot",
			system_prompt = [[
日本語で返答すること
ソフトウェア開発のエキスパートとして行動する。
コーディングの際には常にベストプラクティスを使用すること。
コードベースにすでに存在する既存の規約やライブラリなどを尊重し、使用すること。
]],
			gemini = {
				model = "gemini-2.0-flash-exp", -- 今のところ無料 "models/gemini-exp-1206"
				max_tokens = 8192,
			},
			openai = {
				model = "gpt-4o-mini",
				timeout = 30 * 1000, -- timeout in milliseconds
				temperature = 0, -- adjust if needed
				max_tokens = 4096,
			},
			vendors = {
				deepseek = {
					__inherited_from = "openai",
					api_key_name = "DEEPSEEK_API_KEY",
					endpoint = "https://api.deepseek.com",
					--	model = "deepseek-chat",-- やすい方
					model = "deepseek-reasoner", -- 高い方
				},
				deepseek_chat = {
					__inherited_from = "openai",
					api_key_name = "DEEPSEEK_API_KEY",
					endpoint = "https://api.deepseek.com",
					model = "deepseek-chat", -- やすい方
				},
				-- ["deepseek"] = {
				-- 	endpoint = "http://100.97.82.35:1234/v1",
				-- 	model = "lmstudio-community/DeepSeek-R1-Distill-Llama-8B-GGUF",
				-- 	timeout = 1000 * 30, -- タイムアウト（ミリ秒単位）
				-- 	temperature = 0.7,
				-- 	max_tokens = 8192,
				-- 	["local"] = true,
				-- },
				["Llama-3-ELYZA-JP"] = {
					endpoint = "http://100.97.82.35:1234/v1",
					model = "elyza/Llama-3-ELYZA-JP-8B-GGUF",
					timeout = 1000 * 30, -- タイムアウト（ミリ秒単位）
					temperature = 0.7,
					max_tokens = -1,
					["local"] = true,
					parse_curl_args = function(opts, code_opts)
						return {
							url = opts.endpoint .. "/chat/completions",
							headers = {
								["Accept"] = "application/json",
								["Content-Type"] = "application/json",
							},
							body = {
								model = opts.model,
								messages = require("avante.providers").copilot.parse_message(code_opts), -- 独自のメッセージを作成することも可能（高度な設定）
								temperature = 0.7,
								max_tokens = -1,
								stream = true,
							},
						}
					end,
					parse_response_data = function(data_stream, event_state, opts)
						require("avante.providers").openai.parse_response(data_stream, event_state, opts)
					end,
				},
				["Lalama-3.1"] = {
					endpoint = "http://100.97.82.35:1234/v1",
					model = "lmstudio-community/Meta-Llama-3.1-8B-Instruct-GGUF",
					timeout = 1000 * 30, -- タイムアウト（ミリ秒単位）
					temperature = 0.7,
					max_tokens = -1,
					["local"] = true,
					parse_curl_args = function(opts, code_opts)
						return {
							url = opts.endpoint .. "/chat/completions",
							headers = {
								["Accept"] = "application/json",
								["Content-Type"] = "application/json",
							},
							body = {
								model = opts.model,
								messages = require("avante.providers").copilot.parse_message(code_opts), -- 独自のメッセージを作成することも可能（高度な設定）
								temperature = 0.7,
								max_tokens = -1,
								stream = true,
							},
						}
					end,
					parse_response_data = function(data_stream, event_state, opts)
						require("avante.providers").openai.parse_response(data_stream, event_state, opts)
					end,
				},
			},
			mappings = {
				---@class AvanteConflictMappings
				-- NOTE: 以下はavante.nvimによって安全に設定されます
				ask = "<leader>aa",
				edit = "<leader>ae",
				refresh = "<leader>ar",
				focus = "<leader>af",
				toggle = {
					default = "<leader>at",
					debug = "<leader>ad",
					hint = "<leader>ah",
					suggestion = "<leader>as",
					repomap = "<leader>aR",
				},
				sidebar = {
					apply_all = "A",
					apply_cursor = "a",
					switch_windows = "<Tab>",
					reverse_switch_windows = "<S-Tab>",
				},
			},

			-- ここにオプションを追加
		}
	end,
	-- ソースからビルドする場合は `make BUILD_FROM_SOURCE=true` を実行
	build = "make",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		-- 以下の依存関係はオプションです
		"nvim-tree/nvim-web-devicons", -- または echasnovski/mini.icons
		"takeshid/avante-status.nvim",
		"zbirenbaum/copilot.lua", -- providers='copilot'の場合
		{
			-- 画像貼り付けのサポート
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- 推奨設定
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- Windowsユーザーに必須
					use_absolute_path = true,
				},
			},
		},
	},

	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- windowsの場合
}
