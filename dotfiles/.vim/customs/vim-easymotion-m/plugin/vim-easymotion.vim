if exists('g:loaded_config_easymotion_m')
    finish
endif
let g:loaded_config_easymotion_m = 1

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
nmap <space>s <Plug>(easymotion-overwin-f)
omap <space>s <Plug>(EasyMotion_overwin-f)
omap <space>t <Plug>(EasyMotion_bd-tl)

let g:EasyMotion_use_upper = 1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_smartsign = 1
" }}}

" vim asterisk improved {{{
Plug 'haya14busa/vim-asterisk'
map *   <Plug>(asterisk-*)
map #   <Plug>(asterisk-#)
map g*  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
map z*  <Plug>(asterisk-z*)
map gz* <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)
