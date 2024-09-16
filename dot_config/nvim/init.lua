require("config/options")
require("config/keymaps")
require("config/plugins")
require("config/functions")

vim.cmd([[
autocmd BufRead,BufEnter *.astro set filetype=astro
autocmd BufNewFile,BufRead *.vert,*.tesc,*.tese,*.geom,*.frag,*.comp,*.vs,*.fs set filetype=glsl
autocmd BufRead,BufEnter *.slim set filetype=slim
nmap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
tnoremap <Esc> <C-\><C-n>
colorschem tokyonight
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" hi Normal ctermbg=NONE ctermfg=252 guibg=#NONE guifg=#c6c8d1
]])
