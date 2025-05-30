vim.cmd([[
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 1 " scaling factor for floating window
let g:lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters
" let g:lazygit_floating_window_use_plenary = 0 " use plenary.nvim to manage floating window if available
let g:lazygit_use_neovim_remote = 1 " fallback to 0 if neovim-remote is not installed

nnoremap <silent> <C-l>g :LazyGit<CR>

]])
vim.api.nvim_set_keymap("n", "<Space>lg", "<cmd>LazyGit<cr>", { noremap = true, silent = true, desc = "open lazygit" })
