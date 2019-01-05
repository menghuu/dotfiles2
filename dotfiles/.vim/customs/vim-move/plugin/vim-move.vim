if exists('g:loaded_config_vim_move_m')
    finish
endif
let g:loaded_config_vim_move_m = 1

let g:move_map_keys = 0
let g:move_auto_indent = 0

" configure latter

map <A-]> <Plug>MoveLineDown
map <A-[> <Plug>MoveLineUp
vmap <A-]> <Plug>MoveBlocDown
vmap <A-[> <Plug>MoveBlocUp

map <A-Down> <Plug>MoveLineDown
map <A-Up> <Plug>MoveLineUp
vmap <A-Down> <Plug>MoveBlocDown
vmap <A-Up> <Plug>MoveBlocUp
