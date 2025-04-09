local hop = require("hop")
hop.setup({ keys = "etovqpdygfblzhkisuran" })
local directions = require("hop.hint").HintDirection
local vim = vim

vim.api.nvim_set_keymap("", "<Space>ww", "<cmd>HopWord<cr>", { noremap = true, silent = true, desc = "HopWord" })
-- vim.api.nvim_set_keymap("", "f", "<cmd>HopWord<cr>", { noremap = true, silent = true, desc="HopWord" })
vim.api.nvim_set_keymap("", "<Space>wp", "<cmd>HopPattern<cr>", { noremap = true, silent = true, desc= "HopPattern" })
vim.api.nvim_set_keymap("", "<Space>wa", "<cmd>HopAnywhere<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("", "<Space>wl", "<cmd>HopLine<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("", "<Space>wc", "<cmd>HopWordCurrentLine<cr>", { noremap = true, silent = true })

-- vim.keymap.set("", "<Space>ww", function()
-- 	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
-- end, { remap = true })
-- vim.keymap.set("", "F", function()
-- 	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
-- end, { remap = true })
-- vim.keymap.set("", "t", function()
-- 	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
-- end, { remap = true })
-- vim.keymap.set("", "T", function()
-- 	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
-- end, { remap = true })
