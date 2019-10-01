" File: .vimrc
" Author: mongoose
" Description: my vim config, some come from lemon0910

let g:mapleader=','

"if get(s:, 'loaded', 0) != 0
    "finish
"else
    "let s:loaded = 1
"endif

command! -nargs=1 LoadScript exec 'so ~/.vim/<args>'

" 载入基本设置
LoadScript init-basic.vim

" 载入插件设置
LoadScript init-plugins.vim


"vim:sts=2:sw=2:ts=2
