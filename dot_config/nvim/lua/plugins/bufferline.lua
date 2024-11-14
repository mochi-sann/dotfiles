return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "kyazdani42/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,

        name_formatter = function(buf) -- buf contains:
          -- remove extension from markdown files for example
          return buf.path:match("^.+/(.+)$")
        end,
      },
    })
  end,
}
