return {
	"FabijanZulj/blame.nvim",
	cmd = { "BlameToggle", "BlameOpen" },
	lazy = true,
	config = function()
		require("blame").setup({})
	end,
}
