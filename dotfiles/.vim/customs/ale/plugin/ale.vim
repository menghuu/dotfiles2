if exists('g:config_ale_m')
    finish
endif
let g:config_ale_m=1

let g:ale_fixers = {
  \ 'python': [
    \ 'remove_trailing_lines',
    \ 'trim_whitespace',
    \ 'yapf'
  \ ],
  \ 'vim': [
    \ 'remove_trailing_lines',
    \ 'trim_whitespace'
  \]
\}
