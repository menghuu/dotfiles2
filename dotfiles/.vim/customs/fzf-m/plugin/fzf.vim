if exists('g:loaded_config_fzf_m')
    finish
endif
let g:loaded_config_fzf_m = 1

if executable('fzf')
    noremap <C-p> :<C-u>Commands<CR>
    noremap <C-f> :<C-u>FZF<CR>

    noremap <C-i>b :<C-u>Buffers<CR>
    noremap <C-i><C-b> :<C-u>Buffers<CR>

    noremap <C-i>m :<C-u>Maps<CR>
    noremap <C-i><C-m> :<C-u>Maps<CR>

    noremap <C-i>h :<C-u>History<CR>
    noremap <C-i><C-h> :<C-u>History<CR>

    noremap q: :<C-u>History:<CR>

    noremap <C-i>/ :<C-u>History/<CR>
    noremap <C-i><C-/> :<C-u>History/<CR>

    noremap <C-i>l :<C-u>Lines<CR>
    noremap <C-i><C-l> :<C-u>Lines<CR>

    noremap <C-i>w :<C-u>Windows<CR>
    noremap <C-i><C-w> :<C-u>Windows<CR>
endif
let g:fzf_commands_expect = 'space'
