if exists('g:loaded_config_foldtext_m')
    finish
endif
let g:loaded_config_foldtext_m = 1

let g:vimsyn_folding='af'
let g:tex_fold_enabled=1
let g:xml_syntax_folding = 1
let g:clojure_fold = 1
let ruby_fold = 1
let perl_fold = 1
let perl_fold_blocks = 1
map <silent> zr zr:<c-u>setlocal foldlevel?<CR>
nnoremap <silent> zm zm:<c-u>setlocal foldlevel?<CR>

nnoremap <silent> zR zR:<c-u>setlocal foldlevel?<CR>
nnoremap <silent> zM zM:<c-u>setlocal foldlevel?<CR>

" Change Option Folds
nnoremap zi  :<c-u>call <SID>ToggleFoldcolumn(1)<CR>
nnoremap coz :<c-u>call <SID>ToggleFoldcolumn(0)<CR>
nmap     cof coz

function! s:ToggleFoldcolumn(fold)
  if &foldcolumn
    let w:foldcolumn = &foldcolumn
    silent setlocal foldcolumn=0
    if a:fold | silent setlocal nofoldenable | endif
  else
      if exists('w:foldcolumn') && (w:foldcolumn!=0)
        silent let &l:foldcolumn=w:foldcolumn
      else
        silent setlocal foldcolumn=4
      endif
      if a:fold | silent setlocal foldenable | endif
  endif
  setlocal foldcolumn?
endfunction
