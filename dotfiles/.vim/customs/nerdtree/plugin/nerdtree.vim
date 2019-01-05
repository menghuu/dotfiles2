if exists('g:loaded_config_nerdtree_m')
    finish
endif
let g:loaded_config_nerdtree_m = 1

let NERDTreeQuitOnOpen=0
" inoremap <leader>5 <Esc>:<C-u>NERDTreeToggle<CR>
nnoremap <leader>5 :<C-u>NERDTreeToggle<CR>
xnoremap <leader>5 :<C-u>NERDTreeToggle<CR>
