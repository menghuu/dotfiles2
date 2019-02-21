let g:loaded_config_denite_m = 1
if !exists('g:loaded_config_denite_m')
    let g:loaded_config_denite_m = 1

    "Ripgrep command on grep source
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
    \ ['-i', '--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])

	call denite#custom#option('default', 'prompt', '>')

	call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
	      \ [ '.git/', '.ropeproject/', '__pycache__/',
	      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

    call denite#custom#map('insert', '<Esc>', '<denite:enter_mode:normal>',
      \'noremap')
    call denite#custom#map('normal', '<Esc>', '<NOP>',
          \'noremap')
    call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>',
          \'noremap')
    call denite#custom#map('normal', '<C-v>', '<denite:do_action:vsplit>',
          \'noremap')
    call denite#custom#map('normal', 'dw', '<denite:delete_word_after_caret>',
          \'noremap')

    nnoremap <C-p> :<C-u>Denite file/rec<CR>
    nnoremap <leader>s :<C-u>Denite buffer<CR>
    nnoremap <leader><Space>s :<C-u>DeniteBufferDir buffer<CR>
    nnoremap <leader>8 :<C-u>DeniteCursorWord grep:. -mode=normal<CR>
    nnoremap <leader>/ :<C-u>Denite grep:. -mode=normal<CR>
    nnoremap <leader><Space>/ :<C-u>DeniteBufferDir grep:. -mode=normal<CR>
    nnoremap <leader>d :<C-u>DeniteBufferDir file_rec<CR>
    nnoremap <leader>r :<C-u>Denite -resume -cursor-pos=+1<CR>
    nnoremap <leader>lr :<C-u>Denite references -mode=normal<CR>
endif

if !exists('g:loaded_config_vim_template_m')
  let g:loaded_config_vim_template_m = 1
  let g:tempaltes_user_variables = [
        \   ['MAIL', 'humeng@live.com'],
        \   ['USER', 'mongoose'],
        \ ]
  let g:templates_directory = '~/.vim/templates'
endif
