return {
	{
		"nvim-neotest/neotest",
		event = "VeryLazy",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
			"marilari88/neotest-vitest",
			"nvim-neotest/neotest-vim-test",
			"nvim-neotest/neotest-go",
			-- "nvim-neotest/neotest-plenary",
			{
				"mrcjkb/rustaceanvim",
				version = "^6", -- Recommended
				lazy = false, -- This plugin is already lazy
			},
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-python"),
					require("neotest-vim-test"),
					require("neotest-go"),
					require("neotest-vitest"),
					require("rustaceanvim.neotest"),
					-- require("neotest-plenary"),
				},
			})
		end,
	},
}
