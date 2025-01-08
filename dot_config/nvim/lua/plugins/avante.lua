return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = true,
	version = false, -- set this if you want to always pull the latest change

	opts = {
		debug = false,
		---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
		provider = "gemini", -- Recommend using Claude
		system_prompt = [[
日本語で返答すること
ソフトウェア開発のエキスパートとして行動する。
コーディングの際には常にベストプラクティスを使用すること。
コードベースにすでに存在する既存の規約やライブラリなどを尊重し、使用すること。
]],
		vendors = {
			["deepspeek"] = {

				endpoint = "http://100.97.82.35:1234/v1",
				model = "TheBloke/deepseek-coder-6.7B-instruct-GGUF",
				timeout = 1000 * 30, -- Timeout in milliseconds
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
							messages = require("avante.providers").copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
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
			["Llama-3-ELYZA-JP"] = {
				endpoint = "http://100.97.82.35:1234/v1",
				model = "elyza/Llama-3-ELYZA-JP-8B-GGUF",
				timeout = 1000 * 30, -- Timeout in milliseconds
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
							messages = require("avante.providers").copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
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
				timeout = 1000 * 30, -- Timeout in milliseconds
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
							messages = require("avante.providers").copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
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
			-- NOTE: The following will be safely set by avante.nvim
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

		-- add any opts here
	},
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
		-- "zbirenbaum/copilot.lua", -- for providers='copilot'
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
}
