local hop = require("hop")
hop.setup({ keys = "etovqpdygfblzhkisuran" })

local map = function(lhs, rhs, desc)
	vim.keymap.set("", lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map("<Space>ww", "<cmd>HopWord<cr>", "Hop word")
map("f", "<cmd>HopWord<cr>", "Hop word")
map("<Space>wp", "<cmd>HopPattern<cr>", "Hop pattern")
map("<Space>wa", "<cmd>HopAnywhere<cr>", "Hop anywhere")
map("<Space>wl", "<cmd>HopLine<cr>", "Hop line")
map("<Space>wc", "<cmd>HopWordCurrentLine<cr>", "Hop word (current line)")
