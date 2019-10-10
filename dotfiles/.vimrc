" File: .vimrc
" Author: mongoose
" Description: my vim config, some come from lemon0910

"if get(s:, 'loaded', 0) != 0
    "finish
"else
    "let s:loaded = 1
"endif

" 载入基本设置
exec 'so ~/.vim/basic_cfg.vim'

" 载入插件设置
exec 'so ~/.vim/plugins_cfg.vim'

" vim:sts=2:sw=2:ts=2
