return {
  debug = false,
  ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
  provider = "Lalama-3.1", -- Recommend using Claude
  system_prompt = [[
日本語で返答すること
ソフトウェア開発のエキスパートとして行動する。
コーディングの際には常にベストプラクティスを使用すること。
コードベースにすでに存在する既存の規約やライブラリなどを尊重し、使用すること。
]],
  vendors = {
    ["deepspeek"] = {
      endpoint = "http://192.168.3.4:1234/v1",
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
      endpoint = "http://192.168.3.4:1234/v1",
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
      endpoint = "http://192.168.3.4:1234/v1",
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
}
