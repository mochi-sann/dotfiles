return {
	"pwntester/octo.nvim",
	cmd = { "Octo" },
	keys = {
		{ "<leader>gh", "<cmd>Octo<cr>", desc = "GitHub" },
	},
	config = function()
		require("octo").setup()
	end,
}
