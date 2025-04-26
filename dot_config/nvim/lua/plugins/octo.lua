return {
  "pwntester/octo.nvim",
  lazy = true,
  cmd = { "Octo" },
  event = "VeryLazy",
  keys = {
    { "<leader>gh", "<cmd>Octo<cr>", desc = "GitHub" },
  },
  config = function()
    require "octo".setup()
  end,
}
