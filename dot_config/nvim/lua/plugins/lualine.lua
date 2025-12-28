return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		-- "kyazdani42/nvim-web-devicons",
		-- "takeshid/avante-status.nvim",
		-- { "justinhj/battery.nvim", lazy = false },
		-- "nvim-lua/plenary.nvim",
	},
	event = "VeryLazy",
	config = function()
		-- local avante_chat_component = {
		-- 	function()
		-- 		local chat = require("avante-status").chat_provider
		-- 		local msg = chat.name
		-- 		return msg
		-- 	end,
		-- 	icon = require("avante-status").chat_provider.icon,
		-- 	color = { fg = require("avante-status").chat_provider.fg },
		-- }
		-- local avante_suggestions_component = {
		-- 	function()
		-- 		local suggestions = require("avante-status").suggestions_provider
		-- 		local msg = suggestions.name
		-- 		return msg
		-- 	end,
		-- 	icon = require("avante-status").suggestions_provider.icon,
		-- 	color = { fg = require("avante-status").suggestions_provider.fg },
		-- }
		-- require("battery").setup({})

    -- Bubbles config for lualine
    -- Author: lokesh-krishna
    -- MIT license, see LICENSE for more details.

    -- stylua: ignore
    local colors = {
      blue = '#80a0ff',
      cyan = '#79dac8',
      black = '#080808',
      white = '#c6c6c6',
      red = '#ff5189',
      violet = '#d183e8',
      grey = '#303030'
    }
		-- local nvimbattery = {
		-- 	function()
		-- 		return require("battery").get_status_line()
		-- 	end,
		-- 	color = { fg = colors.violet, bg = colors.bg },
		-- }

		local bubbles_theme = {
			normal = {
				a = { fg = colors.black, bg = colors.violet },
				b = { fg = colors.white, bg = colors.grey },
				c = { fg = colors.black, bg = colors.black },
			},
			insert = { a = { fg = colors.black, bg = colors.blue } },
			visual = { a = { fg = colors.black, bg = colors.cyan } },
			replace = { a = { fg = colors.black, bg = colors.red } },
			inactive = {
				a = { fg = colors.white, bg = colors.black },
				b = { fg = colors.white, bg = colors.black },
				c = { fg = colors.black, bg = colors.black },
			},
		}

		require("lualine").setup({
			options = {
				-- theme = bubbles_theme,
				component_separators = "|",
				section_separators = { left = "", right = "" },
				globalstatus = true,
			},
			sections = {
				lualine_x = {
					-- nvimbattery,
					"encoding",
					"fileformat",
					"filetype",
					-- avante_chat_component,
					-- avante_suggestions_component,
				},
			},
		})
	end,
}
