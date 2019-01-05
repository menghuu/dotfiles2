if exists('g:loaded_config_deoplete_m')
    finish
endif
let g:loaded_config_deoplete_m = 1

" enable deoplete auto start when open vim
let g:deoplete#enable_at_startup=1
" make the doc-preview-window autoclose
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
let g:deoplete#sources#jedi#show_docstring=1
