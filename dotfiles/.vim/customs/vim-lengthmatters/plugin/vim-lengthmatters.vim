if exists('g:loaded_config_lengthmatters_m')
    finish
endif
let g:loaded_config_lengthmatters_m = 1

"call lengthmatters#highlight('ctermbg=0 guibg=#556873')
let g:lengthmatters_on_by_default=1
let g:lengthmatters_excluded = [
    \'fzf',
    \'unite',
    \'tagbar',
    \'startify',
    \'gundo',
    \'vimshell',
    \'w3m',
    \'nerdtree',
    \'help',
    \'qf',
    \'dirvish',
    \'denite',
    \'gitcommit'
    \]
