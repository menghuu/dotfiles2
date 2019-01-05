if exists('g:loadded_config_undotree_m')
    finish
endif
let g:loadded_config_undotree_m = 1

nnoremap <leader>4 :<C-u>UndotreeToggle<CR>
inoremap <leader>4 <ESC>:<C-u>UndotreeToggle<CR>
autocmd BufCreate * if &previewwindow | wincmd K | endif
