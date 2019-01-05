if exists("g:loaded_config_tmux_navigation_m")
    finish
endif
let g:loaded_config_tmux_navigation_m = 1

" tmux nagivation configure
" setting window navigation map include terminal

" the terminal of vim and nvim are not different
" we want to configure theme act like same, but it will be harder than I think
" fix alt key bug(? or problem), from: http://vim.wikia.com/wiki/Fix_meta-keys_that_break_out_of_Insert_mode
" for i in range(97,122)
    " let c = nr2char(i)
    " exec "map \e".c." <M-".c.">"
    " exec "map! \e".c." <M-".c.">"
" endfor
let g:tmux_navigator_no_mappings = 1
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
    tnoremap <silent> <A-h> <C-\><C-N>:TmuxNavigateLeft<cr>
    tnoremap <silent> <A-j> <C-\><C-N>:TmuxNavigateDown<cr>
    tnoremap <silent> <A-k> <C-\><C-N>:TmuxNavigateUp<cr>
    tnoremap <silent> <A-l> <C-\><C-N>:TmuxNavigateRight<cr>
    tnoremap <silent> <A-=> <C-\><C-N>:TmuxNavigatePrevious<cr>
else
    " 这下能在应该在的模式下使用alt键了
    " 包括insert模式
    for i in range(65,90) + range(97,122)
	let c = nr2char(i)
	exec "map \e".c." <M-".c.">"
	exec "map! \e".c." <M-".c.">"

	exec "imap \e".c." <M-".c.">"
	exec "imap \e".c." <M-".c.">"
    endfor
endif
noremap <silent> <A-h> <C-\><C-N>:TmuxNavigateLeft<cr>
noremap <silent> <A-j> <C-\><C-N>:TmuxNavigateDown<cr>
noremap <silent> <A-k> <C-\><C-N>:TmuxNavigateUp<cr>
noremap <silent> <A-l> <C-\><C-N>:TmuxNavigateRight<cr>
noremap <silent> <A-=> <C-\><C-N>:TmuxNavigatePrevious<cr>

" 先从insert模式进入normal模式再进行移动
" 否则移回来的时候忘记了，又按键导致出现不想要的字符
inoremap <silent> <A-h> <C-\><C-N>:TmuxNavigateLeft<cr>
inoremap <silent> <A-j> <C-\><C-N>:TmuxNavigateDown<cr>
inoremap <silent> <A-k> <C-\><C-N>:TmuxNavigateUp<cr>
inoremap <silent> <A-l> <C-\><C-N>:TmuxNavigateRight<cr>
inoremap <silent> <A-=> <C-\><C-N>:TmuxNavigatePrevious<cr>
"}}}
