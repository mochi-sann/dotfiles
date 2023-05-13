require("config/options")
require("config/plugins")
require("config/functions")

vim.cmd([[
autocmd BufRead,BufEnter *.astro set filetype=astro
autocmd BufNewFile,BufRead *.vert,*.tesc,*.tese,*.geom,*.frag,*.comp,*.vs,*.fs set filetype=glsl
autocmd BufRead,BufEnter *.slim set filetype=slim
nmap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
tnoremap <Esc> <C-\><C-n>
colorschem tokyonight

" hi Normal ctermbg=NONE ctermfg=252 guibg=#NONE guifg=#c6c8d1

]])
